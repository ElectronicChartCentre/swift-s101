//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct RecordIdentifier: Hashable {
    
    let rcnm: Int
    let rcid: Int
    
    static func create(_ node: FieldNode) -> RecordIdentifier? {
        
        guard let rcnm = node.valueByLabel["RCNM"] as? Int else {
            return nil
        }
        guard let rcid = node.valueByLabel["RCID"] as? Int else {
            return nil
        }

        return RecordIdentifier(rcnm: rcnm, rcid: rcid)
    }
    
}
