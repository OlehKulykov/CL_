//
//  CharacterRepoMock.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import XCTest
@testable import Domain
@testable import Common

final class CharacterRepoMock: CharacterRepoInterface {
    let characters: [Character]
    
    func getCharacters(_ range: Range<Int>, completion: (Result<Page<Character>, Error>) -> Void) {
        let lowerBound = max(range.lowerBound, 0)
        let upperBound = min(range.upperBound, characters.count)
        let slice = characters[lowerBound..<upperBound]
        completion(.success(Page<Character>(entities: Array<Character>(slice), total: characters.count, ignored: 0)))
    }
    
    init(characters: [Character]) {
        self.characters = characters
    }
}

