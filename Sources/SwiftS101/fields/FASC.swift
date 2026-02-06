//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct FASC: Field, Attributable {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let facd: String
    public let arcd: String
    public let faui: Int

    public let attrs: AttributeFieldList

    static func create(_ node: FieldNode, dsf: DataSetFile, validationResult: ValidationResult) -> FASC? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let nfac = node.valueByLabel["NFAC"] as? Int else {
            return nil
        }
        guard let facd = dsf.generalInformation?.facd(fanc: nfac) else {
            return nil
        }
        guard let narc = node.valueByLabel["NARC"] as? Int else {
            return nil
        }
        guard let arcd = dsf.generalInformation?.arcd(arnc: narc) else {
            return nil
        }

        // why are UKHO putting out bad S-101 test data?
        var faui = node.valueByLabel["FAUI"] as? Int
        if faui == nil {
            faui = node.valueByLabel["APUI"] as? Int
            if faui != nil {
                validationResult.addWarning("FASC.FAUI missing. Using APUI instead.")
            }
        }
        
        guard let faui = faui else {
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

        return FASC(referencedRecordIdentifier: referencedRecordIdentifier, facd: facd, arcd: arcd, faui: faui, attrs: attrs)
    }
    
}
