//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct FACS: Field {
    
    public let facd: String
    public let fanc: Int
    
    static func create(_ node: FieldNode) -> FACS? {
        guard let facd = node.valueByLabel["*FACD"] as? String else {
            return nil
        }
        guard let fanc = node.valueByLabel["FANC"] as? Int else {
            return nil
        }
        return FACS(facd: facd, fanc: fanc)
    }
    
}
