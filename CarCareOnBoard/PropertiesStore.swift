//
//  PropertiesStore.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/26/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import Foundation
import CoreLocation

class PropertiesStore {
  let properties = UserDefaults.standard
  
  var parkingLocationCoordinate: CLLocationCoordinate2D {
    get {
      return CLLocationCoordinate2D(
        latitude: properties.double(forKey: "parkingLatitude"),
        longitude: properties.double(forKey: "parkingLongitude"))
    }
    set(newCoordinate) {
      properties.set(newCoordinate.latitude, forKey: "parkingLatitude")
      properties.set(newCoordinate.longitude, forKey: "parkingLongitude")
      properties.set(NSDate(), forKey: "parkingDate")
      
    }
  }
  
  var parkingLocationDate: NSDate {
    get {
      return properties.value(forKey: "parkingDate") as! NSDate
    }
  }

  var recordsCount: Int {
    get {
      return properties.integer(forKey: "recordsCount")
    }
    set(newCount) {
        return properties.set(newCount, forKey: "recordsCount")
    }
  }
  
  var totalGallons: Double {
    get {
      return properties.double(forKey: "totalGallons")
    }
    set(newGallons) {
        properties.set(newGallons, forKey: "totalGallons")
    }
  }
  
  var totalExpense: Double {
    get {
      return properties.double(forKey: "totalExpense")
    }
    set(newExpense) {
      properties.set(newExpense, forKey: "totalExpense")
    }
  }
  
  var fuelEfficiency: Double {
    get {
      return properties.double(forKey: "fuelEfficiency")
    }
    set(newEfficiency) {
      properties.set(newEfficiency, forKey: "fuelEfficiency")
    }
  }
  
  
  func clearIndicators() {
    
    properties.removeObject(forKey: "recordsCount")
    properties.removeObject(forKey: "totalGallons")
    properties.removeObject(forKey: "totalExpense")
    properties.removeObject(forKey: "fuelEfficiency")
  }
  
  func clearParkingLocationCoordinate() {
    properties.removeObject(forKey: "parkingLatitude")
    properties.removeObject(forKey: "parkingLongitude")
    properties.removeObject(forKey: "parkingDate")
  }
}
