//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct C2IL: Field {
    
    public let ycoo: Int
    public let xcoo: Int
    
    static func create(_ node: FieldNode) -> C2IL? {
        
        guard let ycoo = node.valueByLabel["*YCOO"] as? Int else {
            return nil
        }
        guard let xcoo = node.valueByLabel["XCOO"] as? Int else {
            return nil
        }
        
        return C2IL(ycoo: ycoo, xcoo: xcoo)
    }
    
}
