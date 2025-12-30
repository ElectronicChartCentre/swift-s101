//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct InformationTypeCodesField: Field {
    
    public let itcd: String
    public let itnc: Int
    
    static func create(_ node: FieldNode) -> InformationTypeCodesField? {
        guard let itcd = node.valueByLabel["*ITCD"] as? String else {
            return nil
        }
        guard let itnc = node.valueByLabel["ITNC"] as? Int else {
            return nil
        }
        return InformationTypeCodesField(itcd: itcd, itnc: itnc)
    }
    
}
