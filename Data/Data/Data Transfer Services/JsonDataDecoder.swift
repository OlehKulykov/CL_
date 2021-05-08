//
//  Post.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public struct JsonDataDecoder: DataDecodable {
    private let decoder = JSONDecoder()
    
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}
