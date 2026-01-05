//
//  Test.swift
//  SwiftS101
//

import Testing
import Foundation
@testable import SwiftS101

struct DataSetFileParserTests {

    @Test func testParse101AA00DS0003() async throws {
        // from https://github.com/iho-ohi/S-101-Test-Datasets/blob/main/S-101_Test_DataSets/cells/101AA00DS0003/9/101AA00DS0003.000
        guard let testDataURL = Bundle.module.url(forResource: "TestResources/101AA00DS0003", withExtension: "000") else {
            Issue.record("Could not load test data")
            return
        }

        let dsf = DataSetFileParser.parse(data: try Data.init(contentsOf: testDataURL))
        #expect(dsf != nil)
        #expect(dsf!.generalInformation != nil)
        #expect(dsf!.generalInformation!.dsid.recordIdentifier.rcnm == 10)
        #expect(dsf!.generalInformation!.dsid.recordIdentifier.rcid == 1)
        #expect(dsf!.generalInformation!.dsid.pred == "2.0")
        #expect(dsf!.generalInformation!.dsid.dstcs.count == 2)
        #expect(dsf!.generalInformation!.dssi != nil)
        #expect(dsf!.coordinateReferenceSystem != nil)

        let featureTypeRecords = dsf!.featureTypeRecords()
        #expect(featureTypeRecords.count == 80)
        
        let geometryCreator: GeometryCreator = DefaultGeometryCreator()
        for featureTypeRecord in featureTypeRecords {
            let geometry = featureTypeRecord.createGeometry(dsf: dsf!, creator: geometryCreator)
            #expect(geometry.isEmpty() == false)
        }
        
    }
    
    @Test func testParse101AA00DS0016() async throws {
        // from https://github.com/iho-ohi/S-101-Test-Datasets/blob/main/S-101_Test_DataSets/cells/101AA00DS0016/8/101AA00DS0016.000
        guard let testDataURL = Bundle.module.url(forResource: "TestResources/101AA00DS0016", withExtension: "000") else {
            Issue.record("Could not load test data")
            return
        }

        let dsf = DataSetFileParser.parse(data: try Data.init(contentsOf: testDataURL))
        #expect(dsf != nil)
        #expect(dsf!.generalInformation != nil)
        #expect(dsf!.generalInformation!.dsid.recordIdentifier.rcnm == 10)
        #expect(dsf!.generalInformation!.dsid.recordIdentifier.rcid == 1)
        #expect(dsf!.generalInformation!.dsid.pred == "2.0.0")
        #expect(dsf!.generalInformation!.dsid.dstcs.count == 2)
        #expect(dsf!.generalInformation!.dssi != nil)
        #expect(dsf!.coordinateReferenceSystem != nil)

        let featureTypeRecords = dsf!.featureTypeRecords()
        #expect(featureTypeRecords.count == 356)
        
        let geometryCreator: GeometryCreator = DefaultGeometryCreator()
        for featureTypeRecord in featureTypeRecords {
            let geometry = featureTypeRecord.createGeometry(dsf: dsf!, creator: geometryCreator)
            #expect(geometry.isEmpty() == false)
        }
        
    }

}
