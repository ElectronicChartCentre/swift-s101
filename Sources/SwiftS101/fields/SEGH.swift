//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct SEGH: Field {
    
    public let intp: Int
    
    static func create(_ node: FieldNode) -> SEGH? {
        guard let intp = node.valueByLabel["INTP"] as? Int else {
            return nil
        }
        
        return SEGH(intp: intp)
    }
    
}
