//
//  DataTransferError.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation
import Network

public enum DataTransferError: Error {
    case network(_ : Network.NetworkError)
    case emptyResponse
    case decode(_ : Error)
}
