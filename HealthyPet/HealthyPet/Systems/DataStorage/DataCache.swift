//
//  DataCache.swift
//  HealthyPet
//
//  Created by Kristina Motte on 22.06.2022.
//

import UIKit

class DataCache {
    enum CacheData {
        case single(Data)
        case multiple([Data])
    }
    
    /**
    File/folder names for JSON cache.
    */
    enum DataType: String {
        case dogBreeds
        case catBreeds
        case pets
        case firebaseImage
        
        func isFolder() -> Bool {
            let folderBased: [DataCache.DataType] = [
                .firebaseImage
            ]
            return folderBased.contains(self)
        }
        
        func path() -> String {
            DataCache._cachePath.appendingPathComponent(rawValue)
        }
    }
    
    /**
    Caches the specified data using `dataType` and `identifier` to determine where to save the data.
    
    - parameter data: The data to cache.
    - parameter dataType: Which type of data this is.
    - parameter identifier: Optional identifier (e.g. account ID) for by-folder cached data. If the `dataType.isFolder()` is `true`, this parameter _must_ be non-nil. Defaults to nil.
    */
    class func cache(_ data: Data, dataType: DataType, identifier: String? = nil) throws {
        // Make sure the target directory exists. For non-folder data types, just check the overall cache directory. For folder data types, check <cache dir>/<dataType.rawValue>.
        var folderPath = DataCache._cachePath as String
        if dataType.isFolder() {
            folderPath = (folderPath as NSString).appendingPathComponent(dataType.rawValue)
        }

        var isDirectory: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: folderPath, isDirectory: &isDirectory)

        // Create it if it doesn't exist
        if !(exists && isDirectory.boolValue) {
            try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
        }

        if isDirectory.boolValue {
            // Update directory timestamp with date of latest update.
            try? FileManager.default.setAttributes([.modificationDate: Date()], ofItemAtPath: folderPath)
        }

        // Save file. For folder data types, concatenate path with <identifier>.json
        let fullPath: String
        if dataType.isFolder() {
            guard let identifier = identifier else { return }

            fullPath = (dataType.path() as NSString).appendingPathComponent("\(identifier).json")
        } else {
            fullPath = dataType.path()
        }

        let fullPathURL = URL(fileURLWithPath: fullPath)
        try data.write(to: fullPathURL, options: [.completeFileProtection])
    }

    class func cachedData(for dataType: DataType) -> CacheData? {
        let path = dataType.path()

        if dataType.isFolder() {
            // Get all files in directory
            guard let files = try? FileManager.default.contentsOfDirectory(atPath: path) else {
                NSLog("Can't read contents of cache sub-directory")
                return nil
            }

            var dataArray: [Data] = []
            for file in files {
                let fullPath = (path as NSString).appendingPathComponent(file)
                if let data = try? Data(contentsOf: URL(fileURLWithPath: fullPath)) {
                    dataArray.append(data)
                }
            }

            // Return data array. Note it _is_ possible to return an empty array if the sub-directory was present but contained no files.
            return .multiple(dataArray)
        } else {
            // Single file. Return nil if no file is cached at that path
            if !FileManager.default.fileExists(atPath: path) {
                return nil
            }

            // Return cached data
            if let data = try? Data( contentsOf: URL(fileURLWithPath: path)) {
                return .single(data)
            } else {
                return nil
            }
        }
    }
    
    class func removeCache(for dataType: DataType) {
        let url = URL(fileURLWithPath: dataType.path())
        try? FileManager.default.removeItem(at: url)
    }
    
    class func modifiedDate(for dataType: DataType) -> Date? {
        let url = URL(fileURLWithPath: dataType.path())
        let date = (try? url.resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate
        return date
    }

    // Get age for a given data type. For multiple data the age of the enclosing directory will be used.
    class func age(for dataType: DataType) -> TimeInterval {
        let date = modifiedDate(for: dataType) ?? Date.distantPast
        return Date().timeIntervalSince(date)
    }
    
    // MARK: - Helpers
    // Path for the JSON cache
    private static let _cachePath: NSString = {
        let cacheDirs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = (cacheDirs[0] as NSString).appendingPathComponent("cache/")

        return path as NSString
    }()
}

extension DataCache {
    static func cacheIfPossible<T>(_ value: T, forKey dataType: DataType, identifier: String? = nil) where T: Encodable {
        if let data = try? JSONEncoder().encode(value) {
            try? cache(data, dataType: dataType, identifier: identifier)
        }
    }
}
