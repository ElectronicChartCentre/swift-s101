//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct INAS: Field, Attributable {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let iacd: String
    public let arcd: String
    public let iuin: Int
    
    public let attrs: AttributeFieldList

    static func create(_ node: FieldNode, dsf: DataSetFile, validationResult: ValidationResult) -> INAS? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let niac = node.valueByLabel["NIAC"] as? Int else {
            return nil
        }
        guard let iacd = dsf.generalInformation?.iacd(ianc: niac) else {
            return nil
        }
        guard let narc = node.valueByLabel["NARC"] as? Int else {
            return nil
        }
        guard let arcd = dsf.generalInformation?.arcd(arnc: narc) else {
            return nil
        }
        guard let iuin = node.valueByLabel["IUIN"] as? Int else {
            return nil
        }
        
        let attrs = AttributeFieldList()
        for child in node.children {
            if let attr = ATTR.create(child, dsf: dsf, validationResult: validationResult) {
                attrs.add(attr: attr)
            } else {
                print("ERROR: could not create INAS.ATTR from \(child)")
            }
        }

        return INAS(referencedRecordIdentifier: referencedRecordIdentifier, iacd: iacd, arcd: arcd, iuin: iuin, attrs: attrs)
    }
    
}
