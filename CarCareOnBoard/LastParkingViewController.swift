//
//  LastParkingViewController.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/24/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import MapKit

class LastParkingViewController: UIViewController {

  @IBOutlet weak var parkingMapView: MKMapView!
  
  var locationManager = CLLocationManager()
  let properties = PropertiesStore()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      updateLocation()
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
  
  func updateLocation() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    
    locationManager.startUpdatingLocation()
    if let location = locationManager.location {
      parkingMapView.delegate = self
      parkingMapView.showsScale = true
      parkingMapView.showsCompass = true
      parkingMapView.showsUserLocation = true
      parkingMapView.setCenter(location.coordinate, animated: true)
      parkingMapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpanMake(0.0025, 0.0025)), animated: true)
    
      let annotation = MKPointAnnotation()
      annotation.coordinate = properties.parkingLocationCoordinate
      annotation.title = "Last Parking"
      annotation.subtitle = "On \(properties.parkingLocationDate)"
      parkingMapView.addAnnotation(annotation)
      
      
    }
  }
  @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }

  var carCareDataStore: CarCareStore {
    get {
      return (UIApplication.shared.delegate as! AppDelegate).carCareDataStore
    }
  }
  
}

extension LastParkingViewController: MKMapViewDelegate {
  
}
extension LastParkingViewController: CLLocationManagerDelegate {
  
}
