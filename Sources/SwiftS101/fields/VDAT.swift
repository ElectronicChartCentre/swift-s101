//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct VDAT: Field {
    
    public let dtnm: String
    public let dtid: String
    public let dtsr: Int
    public let scri: String
    
    static func create(_ node: FieldNode) -> VDAT? {
        guard let dtnm = node.valueByLabel["DTNM"] as? String else {
            return nil
        }
        guard let dtid = node.valueByLabel["DTID"] as? String else {
            return nil
        }
        guard let dtsr = node.valueByLabel["DTSR"] as? Int else {
            return nil
        }
        guard let scri = node.valueByLabel["SCRI"] as? String else {
            return nil
        }
        return VDAT(dtnm: dtnm, dtid: dtid, dtsr: dtsr, scri: scri)
    }

    
}
