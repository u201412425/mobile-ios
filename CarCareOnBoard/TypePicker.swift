//
//  TypePicker.swift
//  CarCareOnBoard
//
//  Created by Carlos Escobar on 7/5/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import Foundation
import UIKit

class TypePicker: UIPickerView  {
    let pickerDataSource=["Pekines","Alemán","Poodle","Rottweiler"]
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
}
