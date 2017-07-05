//
//  EntriesViewController.swift
//  CarCareOnBoard
//
//  Created by Angel Velasquez on 6/25/17.
//  Copyright © 2017 UPC. All rights reserved.
//

import UIKit
import Alamofire

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    static func build(cell: EntryTableViewCell, from entry: PetEntry) -> EntryTableViewCell {
        cell.nameLabel.text = "\(entry.petName!)"
        cell.descriptionLabel.text = "\(entry.petDescription!)"
        cell.ageLabel.text = "\(entry.petAge)"
        return cell
    }
}

class EntriesViewController: UITableViewController {
    var entries: [PetEntry] = []
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
    
    override func viewWillAppear(_ animated: Bool) {
        Alamofire.request("http://doggystyle.vcsoft.pe/api/3/Pets").responseJSON { response in
            //print(response.request ?? "NOREQ")  // original URL request
            //print(response.response ?? "NORESP") // HTTP URL response
            //print(response.data ?? "NODATA")     // server data
            //print(response.result)   // result of response serialization
            
            if let result = response.result.value {
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
        let cell = EntryTableViewCell.build(
            cell: tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EntryTableViewCell,
            from: entries[indexPath.row])
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    var carCareDataStore: CarCareStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).carCareDataStore
        }
    }
    
}


