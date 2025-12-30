//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct AttributeCodesField: Field {
    
    public let atcd: String
    public let ancd: Int
    
    static func create(_ node: FieldNode) -> AttributeCodesField? {
        guard let atcd = node.valueByLabel["*ATCD"] as? String else {
            return nil
        }
        guard let ancd = node.valueByLabel["ANCD"] as? Int else {
            return nil
        }
        return AttributeCodesField(atcd: atcd, ancd: ancd)
    }
    
}
