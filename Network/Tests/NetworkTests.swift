//
//  NetworkTests.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    
    func testValidData() {
        let expectation = self.expectation(description: "Should provide valid data.")
        let validData = "hello".data(using: .utf8)
        let service = NetworkService(session: NetworkSessionMock(data: validData), configuration: RequestConfigurationMock())
        service.send(request: Request(GET: "info")) { result in
            expectation.fulfill()
            switch result {
            case .success(let receivedData):
                XCTAssertTrue(receivedData.data == validData)
            default:
                XCTFail("Should be success.")
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testHTTPStatusCode500() {
        let expectation = self.expectation(description: "Should provide error with status code 500.")
        let service = NetworkService(session: NetworkSessionMock(statusCode: 500), configuration: RequestConfigurationMock())
        service.send(request: Request(GET: "info")) { result in
            expectation.fulfill()
            switch result {
            case .failure(let error):
                switch error {
                case .statusCode(code: 500):
                    break
                default:
                    XCTFail("Should be failure with status code 500.")
                }
            default:
                XCTFail("Should be failure.")
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testHTTPError() {
        let expectation = self.expectation(description: "Result as network error.")
        let service = NetworkService(session: NetworkSessionMock(error: URLError(.unknown)), configuration: RequestConfigurationMock())
        service.send(request: Request(GET: "logo")) { result in
            expectation.fulfill()
            switch result {
            case .failure(_):
                break
            default:
                XCTFail("Should be failure.")
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testRequestConfigurationWithSubPath() {
        let expectation = self.expectation(description: "Should not throw any errors.")
        let service = NetworkService(session: NetworkSessionMock(), configuration: RequestConfigurationMock(base: URL(string: "https://my.api.com/v1")!))
        service.send(request: Request(GET: "get/items")) { result in
            expectation.fulfill()
            switch result {
            case .success(_):
                break
            default:
                XCTFail("Should be success.")
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    static var allTests = [
        ("testHTTPError", testHTTPError),
        ("testHTTPStatusCode500", testHTTPStatusCode500),
        ("testValidData", testValidData),
        ("testRequestConfigurationWithSubPath", testRequestConfigurationWithSubPath)
    ]
}
