//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct CSID: Field {

    public let recordIdentifier: RecordIdentifier
    public let ncrc: Int
    
    static func create(_ node: FieldNode) -> CSID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }

        guard let ncrc = node.valueByLabel["NCRC"] as? Int else {
            return nil
        }
        
        return CSID(recordIdentifier: recordIdentifier, ncrc: ncrc)
    }

}
