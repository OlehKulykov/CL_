//
//  Attachment.swift
//  CL_HEADER_PROJECT_NAME
//
//  Created by CL_HEADER_CREATED_BY_ON.
//  Copyright © CL_HEADER_COPYRIGHT. All rights reserved.
//

import Foundation

public enum Attachment {
    case string(String)
    case binary(Data, String?)
    case png(Data, String?)
    case jpeg(Data, String?)
}

public extension Attachment {
    
    var fileName: String? {
        switch self {
        case .binary(_, let fileName),
             .png(_, let fileName),
             .jpeg(_, let fileName):
            return fileName
        default:
            return nil
        }
    }
    
    var contentType: String? {
        switch self {
        case .binary:
            return "application/octet-stream"
        case .png:
            return "image/png"
        case .jpeg:
            return "image/jpeg"
        default:
            return nil
        }
    }
    
    var isBinary: Bool {
        switch self {
        case .binary, .png, .jpeg:
            return true
        default:
            return false
        }
    }
    
    func multipartFormData(boundary: String, name: String) throws -> Data {
        var header = "--\(boundary)\r\n\(HTTPHeaderField.contentDisposition.rawValue): form-data; name=\"\(name)\""
        if let fileName = fileName {
            header += "; filename=\"\(fileName)\""
        }
        if let contentType = contentType {
            header += "\r\n\(HTTPHeaderField.contentType.rawValue): \(contentType)"
        }
        if isBinary {
            header += "\r\n\(HTTPHeaderField.contentTransferEncoding.rawValue): binary"
        }
        header += "\r\n\r\n"
        
        var data = Data()
        try data.append(header)
        
        switch self {
        case .string(let text):
            try data.append(text)
        case .binary(let contentData, _),
             .png(let contentData, _),
             .jpeg(let contentData, _):
            data.append(contentData)
            break
        }
        
        return data
    }
}
