//
//  NetworkSession.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public enum NetworkSessionFormat {
    case json
}

public struct NetworkSessionData {
    let data: Data
    let format: NetworkSessionFormat?
    let encoding: String.Encoding?
    
    init(data: Data, format: NetworkSessionFormat? = nil, encoding: String.Encoding? = nil) {
        self.data = data
        self.format = format
        self.encoding = encoding
    }
}

public protocol NetworkSessionable {
    
    func loadData(request: URLRequest, completion: @escaping (Result<NetworkSessionData, NetworkError>) -> Void)
    
    func invalidate()
}

extension URLSession: NetworkSessionable {
    
    public func loadData(request: URLRequest, completion: @escaping (Result<NetworkSessionData, NetworkError>) -> Void) {
        let task = dataTask(with: request) { (data, response, error) in
            if let error = error as? URLError {
                completion(.failure(.error(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode < 200 || statusCode > 299 {
                    completion(.failure(.statusCode(code: statusCode)))
                    return
                }
            }
            
            completion(.success(NetworkSessionData(data: data ?? Data())))
        }
        task.resume()
    }
    
    public func invalidate() {
        finishTasksAndInvalidate()
    }
}
