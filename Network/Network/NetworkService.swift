//
//  NetworkService.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public protocol NetworkServiceable: AnyObject {
    
    func send(request: Requestable, completion: @escaping (Result<Data?, NetworkError>) -> Void)
}

public final class NetworkService: NetworkServiceable {
    let session: NetworkSessionable
    let configuration: RequestConfigurable
    
    public func send(request: Requestable, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        do {
            let urlRequest = try request.createRequest(config: configuration)
            session.loadData(request: urlRequest) { result in
                completion(result)
            }
        } catch let error as NetworkError {
            completion(.failure(error))
        } catch let error {
            completion(.failure(.error(URLError(.unknown, userInfo: [NSUnderlyingErrorKey: error]))))
        }
    }
    
    init(session: NetworkSessionable, configuration: RequestConfigurable) {
        self.session = session
        self.configuration = configuration
    }
    
    deinit {
        session.invalidate()
    }
}
