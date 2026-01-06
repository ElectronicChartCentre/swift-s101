//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct FASC: Field {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let nfac: Int
    public let narc: Int
    public let faui: Int

    public let attrs: [ATTR]

    static func create(_ node: FieldNode) -> FASC? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let nfac = node.valueByLabel["NFAC"] as? Int else {
            return nil
        }
        guard let narc = node.valueByLabel["NARC"] as? Int else {
            return nil
        }
        guard let faui = node.valueByLabel["FAUI"] as? Int else {
            return nil
        }
        
        var attrs: [ATTR] = []
        for child in node.children {
            if let attr = ATTR.create(child) {
                attrs.append(attr)
            } else {
                print("ERROR: could not create INAS.ATTR from \(child)")
            }
        }

        return FASC(referencedRecordIdentifier: referencedRecordIdentifier, nfac: nfac, narc: narc, faui: faui, attrs: attrs)
    }
    
}
