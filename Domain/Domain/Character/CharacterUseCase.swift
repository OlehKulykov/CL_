//
//  CharacterUseCase.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
import Common

public protocol CharacterUseCaseInterface: AnyObject {
    
    func getCharacters(limit: PageLimit, completion: (Result<Page<Character>, Error>) -> Void) throws
    
    func getCombinedCharacters(nextAfter page: Page<Character>, limit: PageLimit, completion: (Result<Page<Character>, Error>) -> Void) throws
}

public protocol CharacterFilterInterface {
    
    func filter(characters: [Character]) -> [Character]
}

public final class CharacterUseCase: CharacterUseCaseInterface {
    private let charactersRepo: CharacterRepoInterface
    private let charactersFilter: CharacterFilterInterface?
    
    public func getCharacters(limit: PageLimit, completion: (Result<Page<Character>, Error>) -> Void) throws {
        try charactersRepo.getCharacters(0..<Int(limit)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let page):
                let characters = self.charactersFilter?.filter(characters: page.entities) ?? page.entities
                let ignored = page.entities.count - characters.count
                completion(.success(Page<Character>(entities: characters, total: page.total, ignored: ignored)))
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getCombinedCharacters(nextAfter page: Page<Character>, limit: PageLimit, completion: (Result<Page<Character>, Error>) -> Void) throws {
        var combinedCharacters = page.entities
        let ignored = page.ignored
        let lowerBound = ignored + combinedCharacters.count
        let upperBound = UInt(lowerBound) + UInt(limit)
        if upperBound > Int.max {
            throw Exception(what: "The total number of characters is greater than supports int type.", reason: "The total number is: \(upperBound)", file: #file, line: #line)
        }
        try charactersRepo.getCharacters(lowerBound..<Int(upperBound)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let page):
                let characters = self.charactersFilter?.filter(characters: page.entities) ?? page.entities
                combinedCharacters.append(contentsOf: characters)
                let combinedIgnored = ignored + page.entities.count - characters.count
                completion(.success(Page<Character>(entities: combinedCharacters, total: page.total, ignored: combinedIgnored)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    init(repository: CharacterRepoInterface, filter: CharacterFilterInterface? = nil) {
        charactersRepo = repository
        charactersFilter = filter
    }
}
