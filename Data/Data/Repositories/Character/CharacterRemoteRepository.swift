//
//  CharacterRemoteRepository.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
import Domain

public final class CharacterRemoteRepository  {
    
    private let service: DataDecodableTransferServiceable
    
    init(service: DataDecodableTransferServiceable) {
        self.service = service
    }
}

extension CharacterRemoteRepository: Domain.CharacterRepositoryInterface {
    
    public func getCharacters(_ range: Range<Int>, completion: @escaping (Result<Page<Character>, CharacterUseCaseError>) -> Void) {
        let request = DataRequest.characters(range: range)
        service.send(request: request) { (result: Result<CharacterPageModel, DataTransferError>) in
            switch result {
            case .success(let pageModel):
                completion(.success(pageModel.domainObject))
            case .failure(let transferError):
                completion(.failure(.underlying(transferError)))
            }
        }
    }
    
}
