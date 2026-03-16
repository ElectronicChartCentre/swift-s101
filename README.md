# Swift IHO S-101 parser

## Introduction

IHO S-101 is a standard for vector nautical charts. It is built on top of the ISO8211 file format.

This Swift Package uses [swift-iso8211](https://github.com/ElectronicChartCentre/swift-iso8211) to parse ISO8211.

This Swift Package is used by [swift-s100-portrayal](https://github.com/ElectronicChartCentre/swift-s100-portrayal) to portray S-101.

## How to use

```swift
        import SwiftS101
    
        let (dsfb, validationResult) = DataSetFileParser.parse(fileName: "101...000", data: try Data.init(contentsOf: testDataURL))
        let dsf = dsfb.build()
        let geometryCreator: DefaultGeometryCreator()
        for featureTypeRecord in dsf.featureTypeRecords() {
            let geometry = featureTypeRecord.createGeometry(dsf: dsf!, creator: geometryCreator)
        }
```

## Status

Experimental and incomplete.
