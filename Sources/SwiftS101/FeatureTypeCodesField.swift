//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct FeatureTypeCodesField: Field {
    
    public let ftcd: String
    public let ftnc: Int
    
    static func create(_ node: FieldNode) -> FeatureTypeCodesField? {
        guard let ftcd = node.valueByLabel["*FTCD"] as? String else {
            return nil
        }
        guard let ftnc = node.valueByLabel["FTNC"] as? Int else {
            return nil
        }
        return FeatureTypeCodesField(ftcd: ftcd, ftnc: ftnc)
    }
    
}
