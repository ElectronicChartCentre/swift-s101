//
//  File.swift
//  swift-s101
//
//  Created by Tore Halset on 05/01/2026.
//

import Foundation
import SwiftISO8211

public struct FOID: Field {
    
    public let agen: Int
    public let fidn: Int
    public let fids: Int
    
    static func create(_ node: FieldNode) -> FOID? {
        
        guard let agen = node.valueByLabel["AGEN"] as? Int else {
            return nil
        }
        guard let fidn = node.valueByLabel["FIDN"] as? Int else {
            return nil
        }
        guard let fids = node.valueByLabel["FIDS"] as? Int else {
            return nil
        }
        
        return FOID(agen: agen, fidn: fidn, fids: fids)
    }
    
}
