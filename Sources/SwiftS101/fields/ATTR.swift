//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct ATTR: Field {
    
    public let natc: Int
    public let atix: Int
    public let paix: Int
    public let atin: Int
    public let atvl: String
    
    static func create(_ node: FieldNode) -> ATTR? {
        guard let natc = node.valueByLabel["*NATC"] as? Int else {
            return nil
        }
        guard let atix = node.valueByLabel["ATIX"] as? Int else {
            return nil
        }
        guard let paix = node.valueByLabel["PAIX"] as? Int else {
            return nil
        }
        guard let atin = node.valueByLabel["ATIN"] as? Int else {
            return nil
        }
        guard let atvl = node.valueByLabel["ATVL"] as? String else {
            return nil
        }
        return ATTR(natc: natc, atix: atix, paix: paix, atin: atin, atvl: atvl)
    }
    
}
