//
//  Test.swift
//  SwiftS101
//

import Testing
import Foundation

// FoundationNetworking needed on Linux and does not exist on macOS..
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

import ZipArchive
@testable import SwiftS101

struct DataSetFileParserTests {

    @Test func testParse101AA00DS0003() async throws {
        // from https://github.com/iho-ohi/S-101-Test-Datasets/blob/main/S-101_Test_DataSets/cells/101AA00DS0003/9/101AA00DS0003.000
        guard let testDataURL = Bundle.module.url(forResource: "TestResources/101AA00DS0003", withExtension: "000") else {
            Issue.record("Could not load test data")
            return
        }

        let (dsf, validationResult) = DataSetFileParser.parse(data: try Data.init(contentsOf: testDataURL))
        #expect(dsf != nil)
        #expect(dsf!.generalInformation != nil)
        #expect(dsf!.generalInformation!.dsid.recordIdentifier.rcnm == 10)
        #expect(dsf!.generalInformation!.dsid.recordIdentifier.rcid == 1)
        #expect(dsf!.generalInformation!.dsid.pred == "2.0")
        #expect(dsf!.generalInformation!.dsid.dstcs.count == 2)
        #expect(dsf!.generalInformation!.dssi != nil)
        #expect(dsf!.coordinateReferenceSystem != nil)
        
        #expect(validationResult.warnings().isEmpty)

        let featureTypeRecords = dsf!.featureTypeRecords()
        #expect(featureTypeRecords.count == 80)
        
        let geometryCreator: GeometryCreator = DefaultGeometryCreator()
        for featureTypeRecord in featureTypeRecords {
            let geometry = featureTypeRecord.createGeometry(dsf: dsf!, creator: geometryCreator)
            #expect(geometry.isEmpty() == false)
            #expect(geometry.isValid() == true)
        }
        
        let depthAreas = dsf!.featureTypeRecords().filter( { $0.frid.ftcd == "DepthArea" } )
        #expect(depthAreas.isEmpty == false)
        for depthArea in depthAreas {
            #expect(depthArea.attrs.rootNode.children(atcd: "depthRangeMinimumValue").count == 1)
            #expect(depthArea.attrs.rootNode.children(atcd: "depthRangeMaximumValue").count == 1)
            
            let min = depthArea.attrs.rootNode.children(atcd: "depthRangeMinimumValue").first!.attr!.atvl
            let max = depthArea.attrs.rootNode.children(atcd: "depthRangeMaximumValue").first!.attr!.atvl
            
            guard let minValue = Float(min), let maxValue = Float(max) else {
                Issue.record("Could not parse depth values as floats: \(min), \(max)")
                continue
            }
            
            #expect(minValue <= maxValue)
            #expect(minValue >= 0)
        }
        
    }
    
    @Test func testParse101AA00DS0016() async throws {
        // from https://github.com/iho-ohi/S-101-Test-Datasets/blob/main/S-101_Test_DataSets/cells/101AA00DS0016/8/101AA00DS0016.000
        guard let testDataURL = Bundle.module.url(forResource: "TestResources/101AA00DS0016", withExtension: "000") else {
            Issue.record("Could not load test data")
            return
        }

        let (dsf, validationResult) = DataSetFileParser.parse(data: try Data.init(contentsOf: testDataURL))
        #expect(dsf != nil)
        #expect(dsf!.generalInformation != nil)
        #expect(dsf!.generalInformation!.dsid.recordIdentifier.rcnm == 10)
        #expect(dsf!.generalInformation!.dsid.recordIdentifier.rcid == 1)
        #expect(dsf!.generalInformation!.dsid.pred == "2.0.0")
        #expect(dsf!.generalInformation!.dsid.dstcs.count == 2)
        #expect(dsf!.generalInformation!.dssi != nil)
        #expect(dsf!.coordinateReferenceSystem != nil)
        
        #expect(validationResult.warnings().isEmpty)

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
        try await testS101Data(url: "https://www.charts.gc.ca/documents/data-gestion/Unencrypted_S100_DatasetsNov2025.zip", cacheFilePath: "ca-sea-trials.zip")
    }
    
    @Test func testParseUKHOTestS101Data() async throws {
        try await testS101Data(url: "https://datahub.admiralty.co.uk/portal/sharing/rest/content/items/6966cb7ce9454ccf9afbbd3c9a105f9e/data", cacheFilePath: "ukho-test.zip")
    }
    
    @Test func testParseBSHTestS101Data() async throws {
        try await testS101Data(url: "https://linchart60.bsh.de/chartserver/S-100/S-101_DE-Testdata.zip", cacheFilePath: "bsh-test.zip")
    }
    
    private func testS101Data(url: String, cacheFilePath: String) async throws {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: cacheFilePath) {
            print("DEBUG: could not find \(cacheFilePath) locally, so try to download")
            guard let zipURL = URL(string: url) else {
                Issue.record("Invalid test data url")
                return
            }
            
            // URLSession.shared not available on Linux
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            
            let (data, response) = try await session.data(from: zipURL)
            #expect((response as? HTTPURLResponse)?.statusCode == 200)
            #expect(data.count > 0)
            
            try data.write(to: URL(fileURLWithPath: cacheFilePath))
        }
        
        let zipData = try Data(contentsOf: URL(fileURLWithPath: cacheFilePath))
        
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
            let (dsf, validationResult) = DataSetFileParser.parse(data: data)
            guard let dsf = dsf else {
                Issue.record("Could not parse \(fileName) as a S-101 DataSetFile")
                return
            }
            
            if !validationResult.warnings().isEmpty {
                print("DEBUG: \(fileName) has \(validationResult.warnings().count) warnings")
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
