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
        case .characters(let range):
            return Network.Request(GET: "characters",
                                   parameters: [
                                    "limit": "\(range.count)",
                                    "offset": "\(range.startIndex)"
                                   ])
        }
    }
}
