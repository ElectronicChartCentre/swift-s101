//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct MASK: Field {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let mind: Int
    public let muin: Int

    public static let mindTruncatedByDataCoverageLimit = 1
    public static let mindSuppressPortrayal = 2

    static func create(_ node: FieldNode) -> MASK? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let mind = node.valueByLabel["MIND"] as? Int else {
            return nil
        }
        guard let muin = node.valueByLabel["MUIN"] as? Int else {
            return nil
        }

        return MASK(referencedRecordIdentifier: referencedRecordIdentifier, mind: mind, muin: muin)
    }
    
}
