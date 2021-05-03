//
//  Request.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
import Common

public protocol Requestable: AnyObject {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var attachments: [String: Attachment]? { get }
    
    func createRequest(config: RequestConfigurable) throws -> URLRequest
}

public final class Request: Requestable {
    
    public private(set) var path: String
    public private(set) var method: HTTPMethod
    public private(set) var parameters: [String: String]?
    public private(set) var attachments: [String: Attachment]?
    
    private func createUrlEncodedRequest(config: RequestConfigurable, method: HTTPMethod) throws -> URLRequest {
        let url = try Request.createURL(base: config.base, path: path, queryParameters: parameters)
        return Request.createURLRequest(url: url, config: config, method: method)
    }
    
    private func createMultipartFormDataPOSTRequest(config: RequestConfigurable) throws -> URLRequest {
        let url = try Request.createURL(base: config.base, path: path)
        var request = Request.createURLRequest(url: url, config: config, method: .post)
        if let multipartFormData = try Request.createMultipartFormData(parameters: parameters, attachments: attachments) {
            request.httpBody = multipartFormData.1
            request.setValue("multipart/form-data; boundary=\(multipartFormData.0)", forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            request.setValue("\(multipartFormData.1.count)", forHTTPHeaderField: HTTPHeaderField.contentLength.rawValue)
        }
        return request
    }
    
    public func createRequest(config: RequestConfigurable) throws -> URLRequest {
        switch method {
        case .post:
            return try createMultipartFormDataPOSTRequest(config: config)
        default:
            return try createUrlEncodedRequest(config: config, method: method)
        }
    }
    
    public init(GET path: String,
                parameters: [String: String]? = nil) {
        self.path = path
        self.method = .get
        self.parameters = parameters
    }
    
    public init(POST path: String,
                parameters: [String: String]? = nil,
                attachments: [String: Attachment]? = nil) {
        self.path = path
        self.method = .post
        self.parameters = parameters
        self.attachments = attachments
    }
}

//MARK: Generation helpers
private extension Request {
    
    static private func createURL(base: URL,
                                  path: String,
                                  queryParameters: [String: String]? = nil) throws -> URL {
        let combinedUrl = base.appendingPathComponent(path)
        guard let queryParameters = queryParameters, !queryParameters.isEmpty else {
            return combinedUrl
        }
        guard var components = URLComponents(url: combinedUrl, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL, userInfo: [NSURLErrorKey: combinedUrl])
        }
        var queryItems = components.queryItems ?? []
        queryParameters.forEach { (name, value) in
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        components.queryItems = queryItems
        guard let url = components.url else {
            throw URLError(.badURL, userInfo: [NSURLErrorKey: combinedUrl])
        }
        return url
    }
    
    static private func createURLRequest(url: URL,
                                         config: RequestConfigurable,
                                         method: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: config.cachePolicy, timeoutInterval: config.timeoutInterval)
        request.allowsCellularAccess = true
        if #available(iOS 13, macOS 10.15, *) {
            request.allowsExpensiveNetworkAccess = true
        }
        request.httpShouldHandleCookies = false
        request.httpMethod = method.rawValue
        config.headers.forEach { (field, value) in
            request.setValue(value, forHTTPHeaderField: field)
        }
        return request
    }
    
    static private func combine(parameters: [String: String]?,
                                attachments: [String: Attachment]?) -> [String: Attachment]? {
        var combined: [String: Attachment]? = nil
        if let parameters = parameters, parameters.count > 0 {
            combined = parameters.map { (key, value) -> (String, Attachment) in
                return (key, .string(value))
            }
        }
        if let attachments = attachments, attachments.count > 0 {
            if combined?.merge(attachments, uniquingKeysWith: { (_, newValue) in newValue }) == nil {
                combined = attachments
            }
        }
        return combined
    }
    
    static private func createMultipartFormData(parameters: [String: String]?,
                                                attachments: [String: Attachment]?) throws -> (String, Data)? {
        guard
            let combined = combine(parameters: parameters, attachments: attachments),
            combined.count > 0
        else {
            return nil
        }
        
        var data = Data()
        let boundary = "----BOUNDARY\(Int64(Date().timeIntervalSince1970))"
        for (name, attachment) in combined {
            if !data.isEmpty {
                try data.append("\r\n")
            }
            data.append(try attachment.multipartFormData(boundary: boundary, name: name))
        }
        try data.append("\r\n--\(boundary)--")
        return (boundary, data)
    }
}
