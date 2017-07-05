//
//  DashboardViewController.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/25/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

  @IBOutlet weak var gallonsLabel: UILabel!
  @IBOutlet weak var expenseLabel: UILabel!
  @IBOutlet weak var efficiencyLabel: UILabel!
  @IBOutlet weak var recordsLabel: UILabel!
  
  let properties = PropertiesStore()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  override func viewDidAppear(_ animated: Bool) {
    updateDashboard()
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
  
  func updateDashboard() {
    gallonsLabel.text = String(format: "%.2f", properties.totalGallons)
    expenseLabel.text = String(format: "%.2f", properties.totalExpense)
    efficiencyLabel.text = String(format: "%.2f", properties.fuelEfficiency)
    recordsLabel.text = String(format: "%d", properties.recordsCount)
  }

}
