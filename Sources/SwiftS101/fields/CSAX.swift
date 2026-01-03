//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct CSAX: Field {
    
    public let axty: Int
    public let axum: Int
    
    static func create(_ node: FieldNode) -> CSAX? {
        
        guard let axty = node.valueByLabel["*AXTY"] as? Int else {
            return nil
        }
        guard let axum = node.valueByLabel["AXUM"] as? Int else {
            return nil
        }
        
        return CSAX(axty: axty, axum: axum)
    }
    
}
