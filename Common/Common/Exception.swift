//
//  Exception.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public struct Exception: Error {
    
    public let what: String
    public let reason: String
    public let file: String
    public let version: String
    public let line: Int
    
    public init(what: String, reason: String, file: String? = nil, line: Int = 0) {
        self.what = what
        self.reason = reason
        if let file = file {
            self.file = URL(fileURLWithPath: file).lastPathComponent
        } else {
            self.file = ""
        }
        self.line = line
        version = Common.version
    }
}

extension Exception: CustomNSError {

    public var errorCode: Int {
        return 0
    }

    public var errorUserInfo: [String: Any] {
        return [NSLocalizedDescriptionKey: what,
                NSLocalizedFailureReasonErrorKey: reason,
                NSDebugDescriptionErrorKey: description]
    }
    
    public static var errorDomain: String {
        return "CL_"
    }
}

extension Exception: CustomStringConvertible {
    
    public var description: String {
        return "What: \(what)\nReason: \(reason)\nFile: \(file)\nLine: \(line)\nVersion: \(version)"
    }
}

extension Exception: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return description
    }
}