//
//  NetworkSession.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public protocol NetworkSessionable {
    
    func loadData(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void)
    
    func invalidate()
}

extension URLSession: NetworkSessionable {
    
    public func loadData(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        let task = dataTask(with: request) { (data, response, error) in
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    completion(.failure(.notConnected))
                case .cancelled:
                    completion(.failure(.cancelled))
                default:
                    completion(.failure(.error(urlError)))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                if statusCode < 200 || statusCode > 299 {
                    completion(.failure(.statusCode(code: statusCode)))
                    return
                }
            }
            
            completion(.success(data))
        }
        task.resume()
    }
    
    public func invalidate() {
        finishTasksAndInvalidate()
    }
}
