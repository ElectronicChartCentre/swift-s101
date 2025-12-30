//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct AssociationRoleCodesField: Field {
    
    public let arcd: String
    public let arnc: Int
    
    static func create(_ node: FieldNode) -> AssociationRoleCodesField? {
        guard let arcd = node.valueByLabel["*ARCD"] as? String else {
            return nil
        }
        guard let arnc = node.valueByLabel["ARNC"] as? Int else {
            return nil
        }
        return AssociationRoleCodesField(arcd: arcd, arnc: arnc)
    }
    
}
