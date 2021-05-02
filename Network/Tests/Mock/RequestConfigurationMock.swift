//
//  RequestConfigurationMock.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
@testable import Network

struct RequestConfigurationMock: RequestConfigurable {
    
    var base: URL = URL(string: "https://my.apiv1.com")!
    var headers: [String: String] = [:]
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    var timeoutInterval: TimeInterval = 60
}
