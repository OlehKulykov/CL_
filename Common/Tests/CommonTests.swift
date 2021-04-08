//
//  CommonTests.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import XCTest
@testable import Common

final class CommonTests: XCTestCase {
    
    func testCommon() {
        XCTAssertEqual(Common.version, "0.0.0")
    }

    static var allTests = [
        ("testCommon", testCommon)
    ]
}
