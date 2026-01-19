//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct C3IL: Field {
    
    public let c3its: [C3IT]

    static func create(_ node: FieldNode) -> C3IL? {
        
        guard let vcid = node.valueByLabel["VCID"] as? Int else {
            return nil
        }
        
        var c3its: [C3IT] = []
        for child in node.children {
            guard let ycoo = child["*YCOO"] as? Int else {
                continue
            }
            guard let xcoo = child["XCOO"] as? Int else {
                continue
            }
            guard let zcoo = child["ZCOO"] as? Int else {
                continue
            }
            let c3it = C3IT(vcid: vcid, ycoo: ycoo, xcoo: xcoo, zcoo: zcoo)
            c3its.append(c3it)
        }

        return C3IL(c3its: c3its)
    }

}
