//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct FTCS: Field {
    
    public let ftcd: String
    public let ftnc: Int
    
    static func create(_ node: FieldNode) -> FTCS? {
        guard let ftcd = node.valueByLabel["*FTCD"] as? String else {
            return nil
        }
        guard let ftnc = node.valueByLabel["FTNC"] as? Int else {
            return nil
        }
        return FTCS(ftcd: ftcd, ftnc: ftnc)
    }
    
}
