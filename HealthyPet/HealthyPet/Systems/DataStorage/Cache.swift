//
//  Cache.swift
//  HealthyPet
//
//  Created by Kristina Motte on 23.06.2022.
//

import Foundation

class Cache<T> where T: Decodable {
    private var _value: T?
    private var _arrayValue: [T]?
    private var dataType: DataCache.DataType

    init(dataType: DataCache.DataType) {
        self.dataType = dataType
    }

    /// Get model value from cache or 'nil' if absent
    var value: T? {
        get {
            if let object = _value {
                return object
            }

            if let cacheData = DataCache.cachedData(for: dataType), case let .single(data) = cacheData {
                if let object = try? dataType.decoder.decode(T.self, from: data) {
                    _value = object
                    return object
                } else {
                    /// Remove cache if not possible to decode
                    DataCache.removeCache(for: dataType)
                }
            }

            return nil
        }
        set {
            _value = newValue

            if newValue == nil {
                DataCache.removeCache(for: dataType)
            }
        }
    }
    
    /// Get array of valus from cache or 'nil' if absent
    var arrayValue: [T]? {
        get {
            if let object = _arrayValue {
                return object
            }

            if let cacheData = DataCache.cachedData(for: dataType), case let .multiple(dataArray) = cacheData {
                var allObjects: [T] = []
                for data in dataArray {
                    if let object = try? dataType.decoder.decode(T.self, from: data) {
                        allObjects.append(object)
                    }
                }

                /// Remove cache if not possible to decode any item in data array
                if allObjects.isEmpty && !dataArray.isEmpty {
                    DataCache.removeCache(for: dataType)
                }

                _arrayValue = allObjects
                return allObjects
            }

            return nil
        }
        set {
            _arrayValue = newValue

            if newValue == nil {
                DataCache.removeCache(for: dataType)
            }
        }
    }
}
