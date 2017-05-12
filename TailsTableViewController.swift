//
//  TailsTableViewController.swift
//  StokR
//
//  Created by Christopher Martin on 5/11/17.
//  Copyright © 2017 Christopher Martin. All rights reserved.
//

import UIKit

struct AircraftInteriorConfiguration{
    var tail:String
    var cabinetDescriptions:[String]
}

class TailsTableViewController: UITableViewController {

    var superData:[AircraftInteriorConfiguration] = []
    

    
    var data = ["N279DV", "N716DV", "N606MC", "N522AC", "N255DV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let one = AircraftInteriorConfiguration(tail: "N279DV", cabinetDescriptions: ["Liquor", "Medicine", "Drinks", "Top Snack", "Bottom Snack", "Lav Kleenex"])
        
        let two = AircraftInteriorConfiguration(tail: "N716DV", cabinetDescriptions: ["Liquor", "Medicine", "Drinks", "Top Snack", "Bottom Snack", "Lav Kleenex"])
        
        self.superData.append(one)
        self.superData.append(two)
        
        // Uncmment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return self.superData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var i:Int = 0
        
        for aircraftInteriorConfigurations in superData {
            if section == i {
                return aircraftInteriorConfigurations.cabinetDescriptions.count
            }
            i += 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let aircraftInteriorConfiguration = self.superData[section]
        return aircraftInteriorConfiguration.tail
    }
    

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cabinetCell", for: indexPath)

        let aircraftInteriorConfiguration = self.superData[indexPath.section]
        let cabinetDescription = aircraftInteriorConfiguration.cabinetDescriptions[indexPath.row]
        
        (cell as? CabinetDescriptionTableViewCell)?.cabinetLabel.text = cabinetDescription

        return cell
    }
 
    func updateAircraft(tail: String?, row: Int){
        if tail != nil {
            if row >= self.data.count{
                self.data.append(tail!)
            }else{
                self.data[row] = tail!
            }
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func unwindFromEdit(sender: UIStoryboardSegue){
        let editedTail = (sender.source as? EditTailsViewController)?.passedTail
        let row = (sender.source as? EditTailsViewController)?.passedRow
        
        self.updateAircraft(tail: editedTail, row: row!)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        
//        
//        if segue.identifier == "editTailSegue" {
//            
//            let cell = (sender as? TailTableViewCell)
//            let row = self.tableView.indexPath(for: cell!)?.row
//            let tail = cell?.tailLabel.text
//            
//            (segue.destination as? EditTailsViewController)?.passedTail = tail
//            (segue.destination as? EditTailsViewController)?.passedRow = row
//        }
//        
//        if segue.identifier == "addTailSegue" {
//            
//            let editVC = (segue.destination as? EditTailsViewController)
//            editVC?.passedRow = self.data.count
//        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//    }
 

}
