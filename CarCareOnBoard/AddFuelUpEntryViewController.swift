//
//  AddEntryViewController.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/25/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit

class AddFuelUpEntryViewController: UIViewController {

  @IBOutlet weak var gallonsTextField: UITextField!
  
  @IBOutlet weak var unitPriceTextField: UITextField!
  
  @IBOutlet weak var odometerTextField: UITextField!
  
  @IBOutlet weak var locationReferenceTextField: UITextField!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
  @IBAction func cancelAction(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveAction(_ sender: UIBarButtonItem) {
    carCareStore.addFuelUpEntry(gallons: Double.init(gallonsTextField.text!)!, locationReference: locationReferenceTextField.text!, odometer: odometerTextField.text!, unitPrice: Double.init(unitPriceTextField.text!)!, fuelType: carCareStore.defaultFuelType())
    self.dismiss(animated: true, completion: nil)
  }
  
  var carCareStore: CarCareStore {
    get {
      return (UIApplication.shared.delegate as! AppDelegate).carCareDataStore
    }
  }

}
