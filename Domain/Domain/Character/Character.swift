//
//  Character.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public struct Character: Identifiable {
    public typealias ID = UInt
    
    public let id: ID
    public let name: String?
    public let description: String?
    
    public init(id: ID,
                name: String? = nil,
                description: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
    }
}

extension Character: Hashable {
    
    public static func == (left: Character, right: Character) -> Bool {
        return left.id == right.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
