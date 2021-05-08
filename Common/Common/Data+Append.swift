//
//  Data+Append.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public extension Data {
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) -> Bool {
        guard let stringData = string.data(using: encoding) else {
            return false
        }
        append(stringData)
        return true
    }
}
