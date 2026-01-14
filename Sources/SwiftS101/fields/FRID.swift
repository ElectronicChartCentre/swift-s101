//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct FRID: Field {
    
    public let recordIdentifier: RecordIdentifier
    
    public let rver: Int
    public let ruin: Int
    
    public let ftcd: String
    
    static func create(_ node: FieldNode, dsf: DataSetFile, validationResult: ValidationResult) -> FRID? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }
        guard let nftc = node.valueByLabel["NFTC"] as? Int else {
            return nil
        }
        guard let ftcd = dsf.generalInformation?.ftcd(ftnc: nftc) else {
            return nil
        }
        guard let rver = node.valueByLabel["RVER"] as? Int else {
            return nil
        }
        guard let ruin = node.valueByLabel["RUIN"] as? Int else {
            return nil
        }
        
        return FRID(recordIdentifier: recordIdentifier, rver: rver, ruin: ruin, ftcd: ftcd)
    }
    
}
