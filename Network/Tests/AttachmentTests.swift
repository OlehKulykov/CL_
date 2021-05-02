//
//  AttachmentTests.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

import XCTest
@testable import Network

final class AttachmentTests: XCTestCase {

    func testPNGAttachment() {
        let attachment: Attachment = .png(Data(), "logo.png")
        XCTAssertNotNil(attachment.fileName)
        XCTAssertEqual(attachment.fileName, "logo.png")
        XCTAssertTrue(attachment.isBinary)
        XCTAssertEqual(attachment.contentType, "image/png")
    }
    
    func testJPEGAttachment() {
        let attachment: Attachment = .jpeg(Data(), "logo.jpg")
        XCTAssertNotNil(attachment.fileName)
        XCTAssertEqual(attachment.fileName, "logo.jpg")
        XCTAssertTrue(attachment.isBinary)
        XCTAssertEqual(attachment.contentType, "image/jpeg")
    }
    
    func testBinaryAttachment() {
        let attachment: Attachment = .binary(Data(), "logo.bin")
        XCTAssertNotNil(attachment.fileName)
        XCTAssertEqual(attachment.fileName, "logo.bin")
        XCTAssertTrue(attachment.isBinary)
        XCTAssertEqual(attachment.contentType, "application/octet-stream")
    }
    
    func testStringAttachment() {
        let attachment: Attachment = .string("myStringParam")
        XCTAssertNil(attachment.fileName)
        XCTAssertFalse(attachment.isBinary)
        XCTAssertNil(attachment.contentType)
    }
    
    static var allTests = [
        ("testPNGAttachment", testPNGAttachment),
        ("testJPEGAttachment", testJPEGAttachment),
        ("testBinaryAttachment", testBinaryAttachment),
        ("testStringAttachment", testStringAttachment)
    ]
}
