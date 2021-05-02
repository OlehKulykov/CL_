//
//  CharacterFilterMock.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
@testable import Domain

struct CharacterFilterDummyMock: CharacterFilterInterface {
    
    func filter(characters: [Character]) -> [Character] {
        return characters
    }
    
}

struct CharacterFilterByNonEmptyNameMock: CharacterFilterInterface {
    
    func filter(characters: [Character]) -> [Character] {
        characters.filter { character -> Bool in
            return !(character.name?.isEmpty ?? true)
        }
    }

}
