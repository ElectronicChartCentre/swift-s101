//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct ARCS: Field {
    
    public let arcd: String
    public let arnc: Int
    
    static func create(_ node: FieldNode) -> ARCS? {
        guard let arcd = node.valueByLabel["*ARCD"] as? String else {
            return nil
        }
        guard let arnc = node.valueByLabel["ARNC"] as? Int else {
            return nil
        }
        return ARCS(arcd: arcd, arnc: arnc)
    }
    
}
