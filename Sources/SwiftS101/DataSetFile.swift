//
//  File.swift
//  SwiftS101
//

import Foundation
import SwiftGeo
import OrderedCollections

public struct DataSetFile: Sendable {
    
    public let generalInformation: DataSetGeneralInformationRecord?
    public let coordinateReferenceSystem: DataSetCoordinateReferenceSystemRecord?
    
    private let recordByIdentifier: OrderedDictionary<RecordIdentifier, Record>
    
    public init(generalInformation: DataSetGeneralInformationRecord?, coordinateReferenceSystem: DataSetCoordinateReferenceSystemRecord?, recordByIdentifier: OrderedDictionary<RecordIdentifier, Record>) {
        self.generalInformation = generalInformation
        self.coordinateReferenceSystem = coordinateReferenceSystem
        self.recordByIdentifier = recordByIdentifier
    }
    
    public func record(forIdentifier identifier: RecordIdentifier) -> Record? {
        return recordByIdentifier[identifier]
    }
    
    public func records() -> [Record] {
        return Array(recordByIdentifier.values)
    }
    
    public func featureTypeRecords() -> [FeatureTypeRecord] {
        var records: [FeatureTypeRecord] = []
        for record in recordByIdentifier.values {
            if let record = record as? FeatureTypeRecord {
                records.append(record)
            }
        }
        return records
    }
    
    public func boundingBox() -> BoundingBox? {
        let geometryCreator = DefaultGeometryCreator()
        
        var boundingBoxes: [BoundingBox] = []
        for feature in featureTypeRecords() {
            if feature.frid.ftcd != "DataCoverage" {
                continue
            }
            let geometry = feature.createGeometry(dsf: self, creator: geometryCreator)
            if let fb = geometry.bbox() {
                boundingBoxes.append(fb)
            }
        }

        return DefaultBoundingBox.create(boundingBoxes)
    }
    
}

public class DataSetFileBuilder {
    
    public var generalInformation: DataSetGeneralInformationRecordBuilder?
    public var coordinateReferenceSystem: DataSetCoordinateReferenceSystemRecordBuilder?
    
    private var recordByIdentifier: OrderedDictionary<RecordIdentifier, RecordBuilder> = [:]
    
    public func addRecord(_ record: RecordBuilder) {
        recordByIdentifier[record.recordIdentifier()] = record
    }
    
    public func replaceRecord(_ record: RecordBuilder) {
        recordByIdentifier[record.recordIdentifier()] = record
    }
    
    public func removeRecord(_ recordIdentifier: RecordIdentifier) {
        recordByIdentifier.removeValue(forKey: recordIdentifier)
    }
    
    public func record(forIdentifier identifier: RecordIdentifier) -> RecordBuilder? {
        return recordByIdentifier[identifier]
    }
    
    public func records() -> [RecordBuilder] {
        return Array(recordByIdentifier.values)
    }
    
    public func build() -> DataSetFile {
        var recordByIdentifier: OrderedDictionary<RecordIdentifier, Record> = [:]
        for recordBuilder in self.recordByIdentifier.values {
            let record = recordBuilder.build()
            recordByIdentifier[record.recordIdentifier()] = record
        }
        return DataSetFile(generalInformation: generalInformation?.build() as? DataSetGeneralInformationRecord, coordinateReferenceSystem: coordinateReferenceSystem?.build() as? DataSetCoordinateReferenceSystemRecord, recordByIdentifier: recordByIdentifier)
    }
    
}
