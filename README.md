# Swift IHO S-101 parser

## Introduction

IHO S-101 is a standard for vector nautical charts. It is built on top of the ISO8211 file format.

This Swift Package uses [swift-iso8211](https://github.com/ElectronicChartCentre/swift-iso8211) to parse ISO8211.

This Swift Package does not include IHO S-101 Portrayal.

## How to use

```swift
        import SwiftS101
    
        let dsf = DataSetFileParser.parse(data: try Data.init(contentsOf: testDataURL))
        let geometryCreator: DefaultGeometryCreator()
        for featureTypeRecord in featureTypeRecords {
            let geometry = featureTypeRecord.createGeometry(dsf: dsf!, creator: geometryCreator)
        }
```

## Status

Experimental and incomplete.
