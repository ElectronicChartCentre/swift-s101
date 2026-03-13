//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct ATTR: Field, Equatable {
    
    public let atcd: String
    public let atix: Int
    public let paix: Int
    public let atin: Int
    public let atvl: String
    
    static let atinInsert: Int = 1
    static let atinDelete: Int = 2
    static let atinModify: Int = 3

    static func create(_ node: FieldNode, dsf: DataSetFileBuilder, validationResult: ValidationResult) -> ATTR? {
        return create(node.valueByLabel, dsf: dsf, validationResult: validationResult)
    }
    
    static func create(_ valueByLabel: [String: Any], dsf: DataSetFileBuilder, validationResult: ValidationResult) -> ATTR? {
        guard let natc = valueByLabel["*NATC"] as? Int else {
            return nil
        }
        guard let atix = valueByLabel["ATIX"] as? Int else {
            return nil
        }
        guard let paix = valueByLabel["PAIX"] as? Int else {
            return nil
        }
        guard let atin = valueByLabel["ATIN"] as? Int else {
            return nil
        }
        guard let atvl = valueByLabel["ATVL"] as? String else {
            return nil
        }
        guard let atcd = dsf.generalInformation?.atcd(natc) else {
            return nil
        }

        return ATTR(atcd: atcd, atix: atix, paix: paix, atin: atin, atvl: atvl)
    }
    
    func equalsExceptAtin(_ other: ATTR) -> Bool {
        return atcd == other.atcd && atix == other.atix && paix == other.paix && atvl == other.atvl
    }
    
    func equalsExceptAtinAndPaix(_ other: ATTR) -> Bool {
        return atcd == other.atcd && atix == other.atix && atvl == other.atvl
    }
    
}
