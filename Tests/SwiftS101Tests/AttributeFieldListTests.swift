//
//  Test.swift
//  swift-s101
//

import Testing

@testable import SwiftS101

struct AttributeFieldListTests {

    @Test func test() async throws {
        // S-100 10a.4.1.1
        let base = AttributeFieldList()
        let _ = base.add(attr: ATTR(atcd: "21", atix: 1, paix: 0, atin: ATTR.atinInsert, atvl: "Vachon"));
        let a2 = base.add(attr: ATTR(atcd: "22", atix: 1, paix: 0, atin: ATTR.atinInsert, atvl: ""));
        let a5 = base.add(attr: ATTR(atcd: "25", atix: 1, paix: 2, atin: ATTR.atinInsert, atvl: "42.0"));
        let a6 = base.add(attr: ATTR(atcd: "26", atix: 1, paix: 2, atin: ATTR.atinInsert, atvl: ""));
        let a9 = base.add(attr: ATTR(atcd: "29", atix: 1, paix: 4, atin: ATTR.atinInsert, atvl: "17"));
        let _ = base.add(attr: ATTR(atcd: "29", atix: 2, paix: 4, atin: ATTR.atinInsert, atvl: "43"));
        let _ = base.add(attr: ATTR(atcd: "23", atix: 1, paix: 0, atin: ATTR.atinInsert, atvl: "12"));
        let _ = base.add(attr: ATTR(atcd: "24", atix: 1, paix: 0, atin: ATTR.atinInsert, atvl: ""));
        let a7 = base.add(attr: ATTR(atcd: "27", atix: 1, paix: 8, atin: ATTR.atinInsert, atvl: "123"));
        let _ = base.add(attr: ATTR(atcd: "28", atix: 1, paix: 8, atin: ATTR.atinInsert, atvl: "Canada"));
        
        // S-100 10a.4.1.2
        let upd = AttributeFieldList()
        let _ = upd.add(attr: ATTR(atcd: "22", atix: 1, paix: 0, atin: ATTR.atinModify, atvl: ""));
        let _ = upd.add(attr: ATTR(atcd: "26", atix: 1, paix: 1, atin: ATTR.atinModify, atvl: ""));
        let updB5 = upd.add(attr: ATTR(atcd: "29", atix: 2, paix: 2, atin: ATTR.atinInsert, atvl: "32"));
        let updA10 = upd.add(attr: ATTR(atcd: "29", atix: 3, paix: 2, atin: ATTR.atinModify, atvl: "7"));
        let updB2 = upd.add(attr: ATTR(atcd: "35", atix: 1, paix: 2, atin: ATTR.atinInsert, atvl: ""));
        let _ = upd.add(attr: ATTR(atcd: "36", atix: 1, paix: 5, atin: ATTR.atinInsert, atvl: "22"));
        let _ = upd.add(attr: ATTR(atcd: "37", atix: 1, paix: 5, atin: ATTR.atinInsert, atvl: "123"));
        let updB1 = upd.add(attr: ATTR(atcd: "32", atix: 1, paix: 0, atin: ATTR.atinInsert, atvl: "abc"));
        let _ = upd.add(attr: ATTR(atcd: "23", atix: 1, paix: 0, atin: ATTR.atinDelete, atvl: ""));
        let updA4 = upd.add(attr: ATTR(atcd: "24", atix: 1, paix: 0, atin: ATTR.atinModify, atvl: ""));
        let updA8 = upd.add(attr: ATTR(atcd: "28", atix: 1, paix: 10, atin: ATTR.atinModify, atvl: "Germany"));

        // S-100 10a.4.1.2
        base.applyModify(updateAttrs: upd)
        
        // examine tree from root node
        let root = base.rootNode
        
        // number of first level nodes
        #expect(root.allChildren().count == 4)

        // B1 added
        #expect(root.children(atcd: "32").count == 1)
        #expect(root.children(atcd: "32").first!.attr == updB1)
        
        // A3 removed
        #expect(root.children(atcd: "23").count == 0)
        
        // A2 modified
        #expect(root.children(atcd: "22").count == 1)
        #expect(root.children(atcd: "22").first!.attr!.equalsExceptAtin(a2))
        let a2r = root.children(atcd: "22").first!
        #expect(a2r.childrenByAtcd.count == 2)

        // A5
        #expect(a2r.children(atcd: "25").count == 1)
        #expect(a2r.children(atcd: "25").first!.attr!.equalsExceptAtin(a5))
        #expect(a2r.children(atcd: "25").first!.childrenByAtcd.count == 0)

        // A6
        #expect(a2r.children(atcd: "26").count == 1)
        #expect(a2r.children(atcd: "26").first!.attr!.equalsExceptAtin(a6))
        let a6r = a2r.children(atcd: "26").first!
        #expect(a6r.allChildren().count == 4)
        #expect(a6r.children(atcd: "29").count == 3)
        #expect(a6r.children(atcd: "35").count == 1)
        
        // A6 children of same type
        #expect(a6r.children(atcd: "29")[0].attr!.equalsExceptAtin(a9))
        #expect(a6r.children(atcd: "29")[1].attr!.equalsExceptAtin(updB5))
        #expect(a6r.children(atcd: "29")[2].attr!.equalsExceptAtinAndPaix(updA10))
        #expect(a6r.children(atcd: "29")[0].attr!.atix == 1)
        #expect(a6r.children(atcd: "29")[1].attr!.atix == 2)
        #expect(a6r.children(atcd: "29")[2].attr!.atix == 3)

        // A10 modified value
        let a10r = a6r.children(atcd: "29")[2]
        #expect(a10r.attr!.equalsExceptAtinAndPaix(updA10))
        #expect(a10r.attr!.atvl == "7")
        
        // B2
        #expect(a6r.children(atcd: "35")[0].attr!.equalsExceptAtin(updB2))
        let b2r = a6r.children(atcd: "35")[0]
        #expect(b2r.allChildren().count == 2)
        
        // A4
        #expect(root.children(atcd: "24").count == 1)
        #expect(root.children(atcd: "24").first!.attr!.equalsExceptAtin(updA4))
        let a4r = root.children(atcd: "24").first!
        #expect(a4r.allChildren().count == 2)

        // A7
        #expect(a4r.children(atcd: "27").count == 1)
        #expect(a4r.children(atcd: "27")[0].attr!.equalsExceptAtin(a7))
        #expect(a4r.children(atcd: "27")[0].attr!.atvl == "123")

        // A8 modified value
        #expect(a4r.children(atcd: "28").count == 1)
        #expect(a4r.children(atcd: "28").first!.attr!.equalsExceptAtinAndPaix(updA8))
        #expect(a4r.children(atcd: "28").first!.attr!.atvl == "Germany")
    }

}
