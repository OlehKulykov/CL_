//
//  DataDecodableNetworkTransferService.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
import Network

public final class DataDecodableNetworkTransferService {
    
    private let decoder: DataDecodable
    private let service: Network.NetworkServiceable
    
    init(decoder: DataDecodable, service: Network.NetworkServiceable) {
        self.decoder = decoder
        self.service = service
    }
}

extension DataDecodableNetworkTransferService: DataDecodableTransferServiceable {
    
    public func send<T: Decodable>(request: DataRequest, completion: @escaping CompletionHandler<T>) {
        let request = request.networkRequest
        service.send(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let data = data {
                    do {
                        let decodedResult: T = try self.decoder.decode(data)
                        completion(.success(decodedResult))
                    } catch let decodeError {
                        completion(.failure(.decode(decodeError)))
                    }
                } else {
                    completion(.failure(.emptyResponse))
                }
            case .failure(let networkError):
                completion(.failure(.network(networkError)))
            }
        }
    }
    
}
