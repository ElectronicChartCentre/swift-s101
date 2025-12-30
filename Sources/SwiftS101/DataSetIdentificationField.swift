//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct DataSetIdentificationField: Field {
    
    public let recordIdentifier: RecordIdentifier
    
    public let ensp: String
    public let ened: String
    public let prsp: String
    public let pred: String
    public let prof: String
    public let dsnm: String
    public let dstl: String
    public let dsrd: String
    public let dslg: String
    public let dsab: String
    public let dsed: String

    public let dstcs: [Int]
    
    static func create(_ node: FieldNode) -> DataSetIdentificationField? {
        
        guard let recordIdentifier = RecordIdentifier.create(node) else {
            return nil
        }

        guard let ensp = node.valueByLabel["ENSP"] as? String else {
            return nil
        }
        guard let ened = node.valueByLabel["ENED"] as? String else {
            return nil
        }
        guard let prsp = node.valueByLabel["PRSP"] as? String else {
            return nil
        }
        guard let pred = node.valueByLabel["PRED"] as? String else {
            return nil
        }
        guard let prof = node.valueByLabel["PROF"] as? String else {
            return nil
        }
        guard let dsnm = node.valueByLabel["DSNM"] as? String else {
            return nil
        }
        guard let dstl = node.valueByLabel["DSTL"] as? String else {
            return nil
        }
        guard let dsrd = node.valueByLabel["DSRD"] as? String else {
            return nil
        }
        guard let dslg = node.valueByLabel["DSLG"] as? String else {
            return nil
        }
        guard let dsab = node.valueByLabel["DSAB"] as? String else {
            return nil
        }
        guard let dsed = node.valueByLabel["DSED"] as? String else {
            return nil
        }

        var dstcs: [Int] = []
        for child in node.children {
            if let dstc = child["*DSTC"] as? Int {
                dstcs.append(dstc)
            }
        }
        
        return DataSetIdentificationField(recordIdentifier: recordIdentifier, ensp: ensp, ened: ened, prsp: prsp, pred: pred, prof: prof, dsnm: dsnm, dstl: dstl, dsrd: dsrd, dslg: dslg, dsab: dsab, dsed: dsed, dstcs: dstcs)
    }
    
}
