//
//  File.swift
//  SwiftS101
//

import Foundation
import SwiftGeo
import OrderedCollections

public class DataSetFile {
    
    public var generalInformation: DataSetGeneralInformationRecord?
    public var coordinateReferenceSystem: DataSetCoordinateReferenceSystemRecord?
    
    private var recordByIdentifier: OrderedDictionary<RecordIdentifier, Record> = [:]
    
    public func addRecord(_ record: Record) {
        recordByIdentifier[record.recordIdentifier()] = record
    }
    
    public func replaceRecord(_ record: Record) {
        recordByIdentifier[record.recordIdentifier()] = record
    }
    
    public func removeRecord(_ recordIdentifier: RecordIdentifier) {
        recordByIdentifier.removeValue(forKey: recordIdentifier)
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
