//
//  Data+AppendTests.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

import XCTest
@testable import Common

final class Data_AppendTests: XCTestCase {

    func testAppendString() {
        let strings = ["", "Hello", "äг"]
        for string in strings {
            var data = Data()
            XCTAssertTrue(data.append(string))
            if string.isEmpty {
                XCTAssertTrue(data.count == 0)
                XCTAssertTrue(data.isEmpty)
            } else {
                XCTAssertTrue(data.count > 0)
                XCTAssertTrue(!data.isEmpty)
            }
            let reversed = String(data: data, encoding: .utf8)
            XCTAssertEqual(reversed, string)
        }
    }
    
    static var allTests = [
        ("testAppendString", testAppendString)
    ]
}
