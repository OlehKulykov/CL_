//
//  Dictionary+MapTests.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

import XCTest
@testable import Common

final class Dictionary_MapTests: XCTestCase {

    func testMapNumberValuesToStrings() {
        let src: [String: Int] = ["key1": 1]
        let dst: [String: String] = src.map { (key, value) in
            return (key, "\(value)")
        }
        XCTAssertTrue(src.count == dst.count)
        let value1 = dst["key1"]
        XCTAssertNotNil(value1)
        XCTAssertEqual(value1, "1")
    }
    
    static var allTests = [
        ("testMapNumberValuesToStrings", testMapNumberValuesToStrings)
    ]
}
