//
//  CharacterModel.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
import Domain

struct CharacterModel: Decodable {
    let id: UInt
    let name: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UInt.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}

extension CharacterModel: DomainMappable {
    typealias DomainObject = Domain.Character
    
    var domainObject: DomainObject {
        return DomainObject(id: id,
                            name: name,
                            description: description)
    }
    
}
