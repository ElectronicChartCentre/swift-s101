//
//  Test.swift
//  SwiftS101
//
//  Created by Tore Halset on 22/12/2025.
//

import Testing
import Foundation
@testable import SwiftS101

struct DataSetFileParserTests {

    @Test func testParseS101() async throws {
        // from https://github.com/iho-ohi/S-101-Test-Datasets/blob/main/S-101_Test_DataSets/cells/101AA00DS0003/9/101AA00DS0003.000
        guard let testDataURL = Bundle.module.url(forResource: "TestResources/101AA00DS0003", withExtension: "000") else {
            Issue.record("Could not load test data")
            return
        }

        let dsf = DataSetFileParser.parse(data: try Data.init(contentsOf: testDataURL))
        #expect(dsf != nil)
        #expect(dsf!.generalInformation != nil)
        #expect(dsf!.generalInformation!.dsid != nil)
        #expect(dsf!.generalInformation!.dsid!.recordIdentifier.rcnm == 10)
        #expect(dsf!.generalInformation!.dsid!.recordIdentifier.rcid == 1)
        #expect(dsf!.generalInformation!.dsid!.pred == "2.0")
        #expect(dsf!.generalInformation!.dsid!.dstcs.count == 2)
        #expect(dsf!.generalInformation!.dssi != nil)

    }

}
