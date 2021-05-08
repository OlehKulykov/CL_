//
//  DataDecodableTransferServiceable.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public protocol DataDecodableTransferServiceable: AnyObject {

    /// Defines the generic `T` type of the responce as a generic completion.
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void


    /// Sends any request and receives any generic `T` object.
    ///
    /// Any request could be sent to any type of service.
    /// I.e. send to remote/API or to CoreData or to local cache or to 'bundled file'
    ///   and receive any type of responce.
    func send<T: Decodable>(request: DataRequest, completion: @escaping CompletionHandler<T>)
}
