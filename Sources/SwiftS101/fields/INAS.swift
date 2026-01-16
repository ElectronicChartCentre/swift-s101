//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct INAS: Field, Attributable {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let niac: Int
    public let narc: Int
    public let iuin: Int
    
    public let attrs: AttributeFieldList

    static func create(_ node: FieldNode, dsf: DataSetFile, validationResult: ValidationResult) -> INAS? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let niac = node.valueByLabel["NIAC"] as? Int else {
            return nil
        }
        guard let narc = node.valueByLabel["NARC"] as? Int else {
            return nil
        }
        guard let iuin = node.valueByLabel["IUIN"] as? Int else {
            return nil
        }
        
        var attrs = AttributeFieldList()
        for child in node.children {
            if let attr = ATTR.create(child, dsf: dsf, validationResult: validationResult) {
                attrs.add(attr: attr)
            } else {
                print("ERROR: could not create INAS.ATTR from \(child)")
            }
        }

        return INAS(referencedRecordIdentifier: referencedRecordIdentifier, niac: niac, narc: narc, iuin: iuin, attrs: attrs)
    }
    
}
