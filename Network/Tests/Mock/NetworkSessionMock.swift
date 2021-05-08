//
//  NetworkSessionMock.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
@testable import Network

class NetworkSessionMock: NetworkSessionable {
    let data: Data?
    let error: URLError?
    let statusCode: Int
    
    func loadData(request: URLRequest, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        if let data = data {
            completion(.success(data))
            return
        }
        
        if let error = error {
            completion(.failure(.error(error)))
            return
        }
        
        if statusCode != 200 {
            completion(.failure(.statusCode(code: statusCode)))
            return
        }
        
        completion(.success(nil))
    }
    
    func invalidate() {
        
    }
    
    init(data: Data? = nil, error: URLError? = nil, statusCode: Int = 200) {
        self.data = data
        self.error = error
        self.statusCode = statusCode
    }
}
