//
//  DataRequest+Network.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
import Network

internal extension DataRequest {
    
    var networkRequest: Network.Requestable {
        switch self {
        case .characters(_):
            let request = Network.Request(GET: "characters")
            return request
        }
    }
}

