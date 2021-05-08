//
//  CharacterRepositoryInterface.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public protocol CharacterRepositoryInterface {
    
    func getCharacters(_ range: Range<Int>, completion: @escaping (Result<Page<Character>, CharacterUseCaseError>) -> Void)
}
