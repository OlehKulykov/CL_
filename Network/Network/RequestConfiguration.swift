//
//  RequestConfiguration.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public protocol RequestConfigurable {
    var base: URL { get }
    var headers: [String: String] { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }
}

public struct RequestConfiguration: RequestConfigurable {
    
    public var base: URL
    public var headers: [String: String] = [:]
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    public var timeoutInterval: TimeInterval = 60
}
