//
//  ResponsePageModel.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

struct ResponsePageModel<Element> {
    
    let total: Int
    let count: Int
    let results: [Element]
    
    enum CodingKeys: String, CodingKey {
        case total
        case count
        case results
    }
}

extension ResponsePageModel: Codable where Element : Codable {
    
}
