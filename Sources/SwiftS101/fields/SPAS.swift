//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct SPAS: Field {
    
    public let referencedRecordIdentifier: RecordIdentifier
    
    public let ornt: Int
    public let smin: Int
    public let smax: Int
    public let saui: Int
    
    public static let orntForvard = 1
    public static let orntReverse = 2
    public static let orntNull = 255

    static func create(_ node: FieldNode) -> SPAS? {
        
        guard let referencedRecordIdentifier = RecordIdentifier.createReferenced(node) else {
            return nil
        }
        guard let ornt = node.valueByLabel["ORNT"] as? Int else {
            return nil
        }
        guard let smin = node.valueByLabel["SMIN"] as? Int else {
            return nil
        }
        guard let smax = node.valueByLabel["SMAX"] as? Int else {
            return nil
        }
        guard let saui = node.valueByLabel["SAUI"] as? Int else {
            return nil
        }

        return SPAS(referencedRecordIdentifier: referencedRecordIdentifier, ornt: ornt, smin: smin, smax: smax, saui: saui)
    }
    
}
