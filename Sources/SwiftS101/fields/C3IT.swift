//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct C3IT: Field {
    
    public let vcid: Int
    public let ycoo: Int
    public let xcoo: Int
    public let zcoo: Int

    static func create(_ node: FieldNode) -> C3IT? {
        
        guard let vcid = node.valueByLabel["VCID"] as? Int else {
            return nil
        }
        guard let ycoo = node.valueByLabel["YCOO"] as? Int else {
            return nil
        }
        guard let xcoo = node.valueByLabel["XCOO"] as? Int else {
            return nil
        }
        guard let zcoo = node.valueByLabel["ZCOO"] as? Int else {
            return nil
        }

        return C3IT(vcid: vcid, ycoo: ycoo, xcoo: xcoo, zcoo: zcoo)
    }
    
}
