//
//  Character.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public class Character: Identifiable {
    public typealias ID = UInt
    
    public internal(set) var id: ID = 0
    public internal(set) var name: String?
    public internal(set) var description: String?
}

extension Character: Hashable {
    
    public static func == (left: Character, right: Character) -> Bool {
        return left.id == right.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
