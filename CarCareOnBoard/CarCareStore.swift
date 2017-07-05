//
//  CarCareStore.swift
//  CarCareOnBoard
//
//  Created by Profesores on 6/12/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

class CarCareStore {
  let context = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer.viewContext
  let properties = PropertiesStore()
  
  func addFuelType(name: String, about: String) -> FuelType {
    let fuelType = FuelType(context: context)
    fuelType.name = name
    fuelType.about = about
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    return fuelType
  }
  
  func defaultFuelType() -> FuelType {
    let fuelTypes = findAllFuelTypes()
    guard fuelTypes.count > 0 else {
      return addFuelType(name: "Gas 90", about: "90 Octaines Gasoline")
    }
    return fuelTypes.first!
  }
  
  func findAllFuelTypes() -> [FuelType] {
    var fuelTypes: [FuelType] = []
    do {
      fuelTypes = try context.fetch(FuelType.fetchRequest())
    } catch {
      print("Error fetching data from Data Store")
    }
    return fuelTypes
  }
  
  func deleteFuelType(for name: String) {
    let request = NSFetchRequest<FuelType>(entityName: "FuelType")
    do {
      let results = try context.fetch(request)
      for fuelType in results {
        if fuelType.name == name {
          context.delete(fuelType)
        }
      }
    } catch {
      print("Error while deleting: \(error)")
    }
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
  }
  
  func findAllFuelUpEntries() -> [FuelUpEntry] {
    var fuelUpEntries: [FuelUpEntry] = []
    do {
      fuelUpEntries = try context.fetch(FuelUpEntry.fetchRequest())
    } catch {
      print("Error fetching data from Data Store")
    }
    return fuelUpEntries
  }
  
  
  func addFuelUpEntry(gallons: Double, locationReference: String, odometer: String, unitPrice: Double, fuelType: FuelType) {
    let fuelUpEntry = FuelUpEntry(context: context)
    fuelUpEntry.gallons = gallons
    fuelUpEntry.locationReference = locationReference
    fuelUpEntry.odometer = odometer
    fuelUpEntry.fuelType = fuelType
    fuelUpEntry.unitPrice = unitPrice
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    storeIndicators()
  }
  
  func storeIndicators() {
    let entries = findAllFuelUpEntries()
    properties.recordsCount = entries.count
    properties.totalGallons = entries.map({$0.gallons}).reduce(0, +)
    properties.totalExpense = entries.map({$0.gallons*$0.unitPrice}).reduce(0, +)
    properties.fuelEfficiency = self.fuelEfficiency
  }
  

  
  var fuelEfficiency: Double {
    let entries = findAllFuelUpEntries()
    if entries.count < 2 { return 0 }
    var totalEfficiency: Double = 0
    for i in 0...entries.count - 2 {
      totalEfficiency += (Double(entries[i + 1].odometer!)! - Double(entries[i].odometer!)!)/Double(entries[i].gallons)
    }
    
    return totalEfficiency/Double(entries.count - 1)
  }
  
  func deleteAllFuelUpEntries() {
    let request = NSFetchRequest<FuelUpEntry>(entityName: "FuelUpEntry")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request as! NSFetchRequest<NSFetchRequestResult>)
    do {
      try context.execute(deleteRequest)
      try context.save()
      properties.clearIndicators()
    } catch {
      print("Error while deleting")
    }
    
  }
  

}

