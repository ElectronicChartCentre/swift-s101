//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct InformationAssociationCodesField: Field {
    
    public let iacd: String
    public let ianc: Int
    
    static func create(_ node: FieldNode) -> InformationAssociationCodesField? {
        guard let iacd = node.valueByLabel["*IACD"] as? String else {
            return nil
        }
        guard let ianc = node.valueByLabel["IANC"] as? Int else {
            return nil
        }
        return InformationAssociationCodesField(iacd: iacd, ianc: ianc)
    }
    
}
