//
//  CharacterPageModel.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
import Domain

struct CharacterPageModel: Decodable {
    
    let total: Int
    let characters: [CharacterModel]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case characters
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decode(Int.self, forKey: .total)
        characters = try values.decodeIfPresent([CharacterModel].self, forKey: .characters)
    }
}

extension CharacterPageModel: DomainMappable {
    
    typealias DomainObject = Domain.Page<Domain.Character>
    
    var domainObject: DomainObject {
        return DomainObject(entities: characters != nil ? characters!.map({ $0.domainObject }) : [],
                            total: total)
    }
    
}
