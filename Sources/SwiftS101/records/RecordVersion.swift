//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct RecordVersion: Sendable {
    
    public let rver: Int
    public let ruin: Int
    
    public static let ruinInsert: Int = 1
    public static let ruinDelete: Int = 2
    public static let ruinModify: Int = 3

    static func create(_ node: FieldNode) -> RecordVersion? {
        guard let rver = node.valueByLabel["RVER"] as? Int else {
            return nil
        }
        guard let ruin = node.valueByLabel["RUIN"] as? Int else {
            return nil
        }

        return RecordVersion(rver: rver, ruin: ruin)
    }
    
}
