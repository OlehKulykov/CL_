//
//  Dictionary+Map.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    func map<T: Hashable, U>(transform: (Key, Value) -> (T, U)) -> [T: U] {
        var result: [T: U] = [:]
        for (key, value) in self {
            let transformed = transform(key, value)
            result[transformed.0] = transformed.1
        }
        return result
    }
    
    func map<T: Hashable, U>(transform: (Key, Value) throws -> (T, U)) rethrows -> [T: U] {
        var result: [T: U] = [:]
        for (key, value) in self {
            let transformed = try transform(key, value)
            result[transformed.0] = transformed.1
        }
        return result
    }
}
