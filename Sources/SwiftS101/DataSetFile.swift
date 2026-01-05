//
//  File.swift
//  SwiftS101
//

import Foundation

public class DataSetFile {
    
    public var generalInformation: DataSetGeneralInformationRecord?
    public var coordinateReferenceSystem: DataSetCoordinateReferenceSystemRecord?
    
    private var recordByIdentifier: [RecordIdentifier: Record] = [:]
    
    public func addRecord(_ record: Record) {
        recordByIdentifier[record.recordIdentifier()] = record
    }
    
    public func record(forIdentifier identifier: RecordIdentifier) -> Record? {
        return recordByIdentifier[identifier]
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
    
}
