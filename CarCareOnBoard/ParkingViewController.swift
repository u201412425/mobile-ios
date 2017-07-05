//
//  ParkingViewController.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/25/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import CoreLocation

class ParkingViewController: UIViewController {
    let locationManager = CLLocationManager()
    let properties = PropertiesStore()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()

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
  @IBAction func keepLocationAction(_ sender: UIButton) {
    if let location = locationManager.location {
      properties.parkingLocationCoordinate = location.coordinate
    }
  }
  
  var carCareDataStore: CarCareStore {
    get {
      return (UIApplication.shared.delegate as! AppDelegate).carCareDataStore
    }
  }

}

extension ParkingViewController: CLLocationManagerDelegate {
  
}
