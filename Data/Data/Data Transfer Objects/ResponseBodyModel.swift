//
//  ResponseBodyModel.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

struct ResponseBodyModel<Element> {

    let code: Int
    let data: ResponsePageModel<Element>
    
    enum CodingKeys: String, CodingKey {
        case code
        case data
    }
}

extension ResponseBodyModel: Codable where Element : Codable {
    
}
