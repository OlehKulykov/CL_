//
//  Page.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public typealias PageLimit = UInt16

public struct Page<T> {
    public let entities: [T]
    public let total: Int
    public let ignored: Int
    
    public init(entities: [T], total: Int, ignored: Int = 0) {
        self.entities = entities
        self.total = total
        self.ignored = ignored
    }
    
}
