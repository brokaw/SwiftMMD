//
//  MultiMarkdown.swift
//  SwiftMMD
//
//  Created by Steve Brokaw on 11/18/15.
//  Copyright © 2015 Steven Brokaw. All rights reserved.
//

import Foundation

public struct ParserExtension: OptionSetType {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    public static let Compatibility = ParserExtension(rawValue: UInt(EXT_COMPATIBILITY.rawValue))
    public static let Complete = ParserExtension(rawValue: UInt(EXT_COMPLETE.rawValue))
    //etc
}

public enum ExportFormat: UInt32 {
    case HTML
}
public func mmd_string_to_markdown(string: String) -> String? {
    let output = markdown_to_string(string, UInt(EXT_COMPLETE.rawValue), Int32(HTML_FORMAT.rawValue))
    let str = String.fromCString(output)
    free(output)
    return str
}

public extension String {

    public func mmdToHTMLDocument() -> String? {
        let output = markdown_to_string(self, UInt(EXT_COMPLETE.rawValue), Int32(HTML_FORMAT.rawValue))
        let str = String.fromCString(output)
        free(output)
        return str
    }
    public func mmdRenderToFormat(format: export_formats, extensions: parser_extensions) -> String? {
        let output = markdown_to_string(self, UInt(extensions.rawValue), Int32(format.rawValue))
        let str = String.fromCString(output)
        free(output)
        return str
    }
    public func mmdRenderToFormat(format: ExportFormat, extensions: ParserExtension) -> String? {
        let format: export_formats = export_formats(format.rawValue)
        let ext: parser_extensions = parser_extensions(1)
        self.mmdRenderToFormat(format, extensions: extensions)
    }
    public func mmdHasMetadataWithExtenstion(extensions: parser_extensions) -> Bool {
        return has_metadata(self, UInt(extensions.rawValue))
    }
    public func mmdMetadataKeysWithExtensions(extensions: parser_extensions) -> String? {
        let output = extract_metadata_keys(self, UInt(extensions.rawValue))
        let str = String.fromCString(output)
        free(output)
        return str
    }

    public func mmdMetadataValueForKey(key:String, extensions: parser_extensions) -> String? {
        let keyData = key.dataUsingEncoding(NSUTF8StringEncoding)!
        let keyPtr = UnsafeMutablePointer<Int8>(keyData.bytes)
        let output = extract_metadata_value(self, UInt(extensions.rawValue), keyPtr)
        let str = String.fromCString(output)
        free(output)
        return str
    }
}