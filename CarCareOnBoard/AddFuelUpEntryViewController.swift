//
//  AddEntryViewController.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/25/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import Alamofire

class AddFuelUpEntryViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var caracteristicasLabel: UITextField!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var ageLabel: UILabel!
    var data: PetEntry? = nil
    var ageValue = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let entry = data else {
            return
        }
        nameLabel.text = entry.petName
        descriptionLabel.text = entry.petDescription
        caracteristicasLabel.text = entry.petCharacteristics
        slider.value = Float(entry.petAge)
        ageLabel.text = String(format: "%d años", entry.petAge)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func valueChanged(_ sender: Any) {
        ageValue = Int(slider.value)
        ageLabel.text = String(format: "%d años", ageValue)
    }
    let pickerDataSource=["Perro","Gato"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
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
    let parameters: Parameters = [
        "UserId": 3,
        "NamePet": nameLabel.text!,
        "Description": descriptionLabel.text!,
        "State": "ACT",
        "Type": 1,
        "SpecialFeatures": caracteristicasLabel.text!,
        "Age": ageValue,
        "ImagenUrl": "http://vcsoft.pe/images/mem3.png"
    ]
    var url = "http://doggystyle.vcsoft.pe/api/Pets/0"
    if data != nil {
        let id = data!.petId
        url = "http://doggystyle.vcsoft.pe/api/Pets/\(id)"
    }
    Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response.request ?? "NOREQ")  // original URL request
            print(response.response ?? "NORESP") // HTTP URL response
            print(response.data ?? "NODATA")     // server data
            print(response.result)   // result of response serialization
            self.dismiss(animated: true, completion: nil)
        }
  }
  
  var carCareStore: CarCareStore {
    get {
      return (UIApplication.shared.delegate as! AppDelegate).carCareDataStore
    }
  }

}
