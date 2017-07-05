//
//  SettingsViewController.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/25/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import CoreLocation

class SettingsViewController: UIViewController {
  @IBOutlet weak var clearEntriesButton: UIButton!

  @IBOutlet weak var clearParkingButton: UIButton!
  
  let properties = PropertiesStore()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  override func viewWillAppear(_ animated: Bool) {
    clearEntriesButton.isEnabled = carCareDataStore.findAllFuelUpEntries().count > 0
    clearParkingButton.isEnabled = properties.parkingLocationCoordinate.latitude != 0 && properties.parkingLocationCoordinate.longitude != 0
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func clearEntriesAction(_ sender: UIButton) {
    carCareDataStore.deleteAllFuelUpEntries()
    clearEntriesButton.isEnabled = false
  }
  
  @IBAction func clearParkingButton(_ sender: UIButton) {
    properties.clearParkingLocationCoordinate()
    clearParkingButton.isEnabled = false
  }
  
  var carCareDataStore: CarCareStore {
    get {
      return (UIApplication.shared.delegate as! AppDelegate).carCareDataStore
    }
  }
  
}
