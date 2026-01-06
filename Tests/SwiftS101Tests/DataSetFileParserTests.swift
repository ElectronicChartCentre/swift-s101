//
//  Test.swift
//  SwiftS101
//

import Testing
import Foundation
import ZipArchive
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
            #expect(geometry.isValid() == true)
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
            #expect(geometry.isValid() == true)
        }
        
    }
    
    @Test func testParseCASeaTrialsS101Data() async throws {
        // download CA SeaTrials data. Do not include in this repo as of distribution agreement.
        let localZipFilePath = "ca-sea-trials.zip"
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: localZipFilePath) {
            print("DEBUG: could not find \(localZipFilePath) locally, so try to download")
            guard let zipURL = URL(string: "https://www.charts.gc.ca/documents/data-gestion/Unencrypted_S100_DatasetsNov2025.zip") else {
                Issue.record("Invalid test data url")
                return
            }
            
            let (data, response) = try await URLSession.shared.data(from: zipURL)
            #expect((response as? HTTPURLResponse)?.statusCode == 200)
            #expect(data.count > 0)
            
            try data.write(to: URL(fileURLWithPath: localZipFilePath))
        }
        
        let zipData = try Data(contentsOf: URL(fileURLWithPath: localZipFilePath))
        
        var fileDataByName: [String: Data] = [:]
        let reader = try ZipArchiveReader(buffer: zipData)
        for fileHeader in try reader.readDirectory() {
            if fileHeader.isDirectory {
                continue
            }
            guard let filename = fileHeader.filename.lastComponent?.string else {
                continue
            }
            if !filename.hasPrefix("101") || !filename.hasSuffix(".000") {
                continue
            }
            let fileContents = Data(try reader.readFile(fileHeader))
            fileDataByName[filename] = fileContents
        }
        
        #expect(!fileDataByName.isEmpty)
        
        for (fileName, data) in fileDataByName {
            print("DEBUG: start reading \(fileName)")
            guard let dsf = DataSetFileParser.parse(data: data) else {
                Issue.record("Could not parse \(fileName) as a S-101 DataSetFile")
                return
            }
            
            let featureTypeRecords = dsf.featureTypeRecords()
            #expect(featureTypeRecords.count > 0)

            let geometryCreator: GeometryCreator = DefaultGeometryCreator()
            for featureTypeRecord in featureTypeRecords {
                let geometry = featureTypeRecord.createGeometry(dsf: dsf, creator: geometryCreator)
                #expect(geometry.isEmpty() == false)
                #expect(geometry.isValid() == true)
            }
        }
        
    }

}
