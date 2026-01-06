//
//  File.swift
//  swift-s101
//

import Foundation
import SwiftISO8211

public struct DSSI: Field {
    
    public let dcox: Float
    public let dcoy: Float
    public let dcoz: Float
    public let cmfx: Int
    public let cmfy: Int
    public let cmfz: Int
    public let noir: Int
    public let nopn: Int
    public let nomn: Int
    public let nocn: Int
    public let noxn: Int
    public let nosn: Int
    public let nofr: Int
    
    public func createCoordinate2D(xcoo: Int, ycoo: Int, creator: any GeometryCreator) -> Coordinate {
        let x = Double(dcox) + Double(xcoo) / Double(cmfx)
        let y = Double(dcoy) + Double(ycoo) / Double(cmfy)
        return creator.createCoordinate2D(xcoo: xcoo, ycoo: ycoo, x: x, y: y)
    }
    
    public func createCoordinate3D(xcoo: Int, ycoo: Int, zcoo: Int, creator: any GeometryCreator) -> Coordinate {
        let x = Double(dcox) + Double(xcoo) / Double(cmfx)
        let y = Double(dcoy) + Double(ycoo) / Double(cmfy)
        let z = Double(dcoz) + Double(zcoo) / Double(cmfz)
        return creator.createCoordinate3D(xcoo: xcoo, ycoo: ycoo, zcoo: zcoo, x: x, y: y, z: z)
    }

    static func create(_ node: FieldNode) -> DSSI? {
        
        guard let dcox = node.valueByLabel["DCOX"] as? Float else {
            return nil
        }
        guard let dcoy = node.valueByLabel["DCOY"] as? Float else {
            return nil
        }
        guard let dcoz = node.valueByLabel["DCOZ"] as? Float else {
            return nil
        }
        guard let cmfx = node.valueByLabel["CMFX"] as? Int else {
            return nil
        }
        guard let cmfy = node.valueByLabel["CMFY"] as? Int else {
            return nil
        }
        guard let cmfz = node.valueByLabel["CMFZ"] as? Int else {
            return nil
        }
        guard let noir = node.valueByLabel["NOIR"] as? Int else {
            return nil
        }
        guard let nopn = node.valueByLabel["NOPN"] as? Int else {
            return nil
        }
        guard let nomn = node.valueByLabel["NOMN"] as? Int else {
            return nil
        }
        guard let nocn = node.valueByLabel["NOCN"] as? Int else {
            return nil
        }
        guard let noxn = node.valueByLabel["NOXN"] as? Int else {
            return nil
        }
        guard let nosn = node.valueByLabel["NOSN"] as? Int else {
            return nil
        }
        guard let nofr = node.valueByLabel["NOFR"] as? Int else {
            return nil
        }

        return DSSI(dcox: dcox, dcoy: dcoy, dcoz: dcoz, cmfx: cmfx, cmfy: cmfy, cmfz: cmfz, noir: noir, nopn: nopn, nomn: nomn, nocn: nocn, noxn: noxn, nosn: nosn, nofr: nofr)
    }

}
