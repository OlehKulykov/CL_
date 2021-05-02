//
//  NetworkError.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case error(_ : URLError)
    case statusCode(code: Int)
}
