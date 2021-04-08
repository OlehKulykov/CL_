//
//  DataTests.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import XCTest
@testable import Data

final class DataTests: XCTestCase {
    
    func testData() {
        
    }
    
    func testPost() {
        let post = Post()
        XCTAssertEqual(post.version, "0.0.0")
    }

    static var allTests = [
        ("testData", testData),
        ("testPost", testPost)
    ]
}
