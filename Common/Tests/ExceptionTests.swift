//
//  ExceptionTests.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

import XCTest
@testable import Common

final class ExceptionTests: XCTestCase {

    func testURLUnderlingError() {
//        let urlError = URLError(.unknown, userInfo: [:])
//        let exception = Exception(file: #file, line: #line, underlingError: urlError)
//        let userInfo = exception.errorUserInfo
//        let underlingError = userInfo[NSUnderlyingErrorKey] as? NSError
//        XCTAssertNotNil(underlingError)
        //XCTAssertEqual(underlingError, urlError)
    }
    
    func testNSUnderlingError() {
//        let nsError = NSError(domain: "testDomain", code: 0, userInfo: nil)
//        let exception = Exception(file: #file, line: #line, underlingError: nsError)
//        let userInfo = exception.errorUserInfo
//        let underlingError = userInfo[NSUnderlyingErrorKey] as? NSError
//        XCTAssertNotNil(underlingError)
//        XCTAssertEqual(underlingError, nsError)
    }
    
    static var allTests = [
        ("testURLUnderlingError", testURLUnderlingError),
        ("testNSUnderlingError", testNSUnderlingError)
    ]
}

