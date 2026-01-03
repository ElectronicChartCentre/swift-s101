//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct ATCS: Field {
    
    public let atcd: String
    public let ancd: Int
    
    static func create(_ node: FieldNode) -> ATCS? {
        guard let atcd = node.valueByLabel["*ATCD"] as? String else {
            return nil
        }
        guard let ancd = node.valueByLabel["ANCD"] as? Int else {
            return nil
        }
        return ATCS(atcd: atcd, ancd: ancd)
    }
    
}
