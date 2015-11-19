//
//  MultiMarkdown.swift
//  SwiftMMD
//
//  Created by Steve Brokaw on 11/18/15.
//  Copyright © 2015 Steven Brokaw. All rights reserved.
//

import Foundation

struct MMDExtensions: OptionSetType {
    let rawValue: UInt
    init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    static let Compatibility = MMDExtensions(rawValue: UInt(EXT_COMPATIBILITY.rawValue))
    static let Complete = MMDExtensions(rawValue: UInt(EXT_COMPLETE.rawValue))
    //etc
}

public func mmd_string_to_markdown(string: String) -> String {
    let output = markdown_to_string(string, UInt(EXT_COMPLETE.rawValue), Int32(HTML_FORMAT.rawValue))
    return String.cStringToString(output)
}

public extension String {

    public func mmdToHTMLDocument() -> String {
        let output = markdown_to_string(self, 1, Int32(HTML_FORMAT.rawValue))
        return String.cStringToString(output)
    }
    public func mmdRenderToFormat(format: export_formats, extensions: parser_extensions) -> String {
        let output = markdown_to_string(self, UInt(extensions.rawValue), Int32(format.rawValue))
        return String.cStringToString(output)
    }
    public func mmdHasMetadataWithExtenstion(extensions: parser_extensions) -> Bool {
        return has_metadata(self, UInt(extensions.rawValue))
    }
    public func mmdMetadataKeysWithExtensions(extensions: parser_extensions) -> String {
        let output = extract_metadata_keys(self, UInt(extensions.rawValue))
        return String.cStringToString(output)
    }

    public func mmdMetadataValueForKey(key:String, extensions: parser_extensions) -> String {
        let keyData = key.dataUsingEncoding(NSUTF8StringEncoding)!
        let keyPtr = UnsafeMutablePointer<Int8>(keyData.bytes)
        let output = extract_metadata_value(self, UInt(extensions.rawValue), keyPtr)
        return String.cStringToString(output)
    }

    static private func cStringToString(cString: UnsafeMutablePointer<Int8>) -> String {
        let len = Int(strlen(cString))
        let data = NSData(bytes: cString, length: len)
        let str = String(data: data, encoding: NSUTF8StringEncoding)!
        free(cString)
        return str
    }

}