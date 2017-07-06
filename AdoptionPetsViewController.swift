//
//  AdoptionPetsViewController.swift
//  
//
//  Created by Carlos Escobar on 7/5/17.
//
//

import Foundation
//
//  EntriesViewController.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/25/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import Alamofire

class AdoptionPetsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    static func build(cell: AdoptionPetsTableViewCell, from entry: PetEntry) -> AdoptionPetsTableViewCell {
        cell.nameLabel.text = "\(entry.petName!)"
        cell.descriptionLabel.text = "\(entry.petDescription!)"
        cell.ageLabel.text = "\(entry.petAge)"
        return cell
    }
}

class AdoptionPetsViewController: UITableViewController {
    var entries: [PetEntry] = []
    var entry = PetEntry()
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //entries = carCareDataStore.findAllFuelUpEntries()
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        entry=entries[indexPath.row]
        self.performSegue(withIdentifier: "adoptionDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the second view controller
        let secondViewController = segue.destination as! UINavigationController
        let innerController = secondViewController.viewControllers.first as! AddFuelUpEntryViewController
        // set a variable in the second view controller with the data to pass
        innerController.data = entry
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Alamofire.request("http://doggystyle.vcsoft.pe/api/petadoption").responseJSON { response in
            //print(response.request ?? "NOREQ")  // original URL request
            //print(response.response ?? "NORESP") // HTTP URL response
            //print(response.data ?? "NODATA")     // server data
            //print(response.result)   // result of response serialization
            
            if let result = response.result.value {
                self.entries.removeAll()
                let JSON = result as! NSDictionary
                guard let petArray = JSON["Result"] as? [NSDictionary] else{
                    return
                }
                for  element in petArray  {
                    let entry = PetEntry(context: self.context)
                    entry.petId = element["PetId"] as! Int32
                    entry.petAge = element["Age"] as! Int32
                    entry.userId = element["UserId"] as! Int32
                    entry.petName = element["NamePet"] as? String
                    entry.petDescription = element["Description"] as? String
                    entry.petCharacteristics = element["SpecialFeatures"] as? String
                    self.entries.append(entry)
                }
                //entries = carCareDataStore.findAllFuelUpEntries()
                print("Entries count when will appear is \(self.entries.count)")
                self.tableView.reloadData()
                //print("JSON: \(result)")
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("Entries count is \(entries.count)")
        return entries.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = AdoptionPetsTableViewCell.build(
            cell: tableView.dequeueReusableCell(withIdentifier: "AdoptionCell", for: indexPath) as! AdoptionPetsTableViewCell,
            from: entries[indexPath.row])
        return cell
    }
    var carCareDataStore: CarCareStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).carCareDataStore
        }
    }
    
}


