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
    var cabinetDescriptions:[[String:UIImage?]]
    
    init(){
        self.tail = ""
        self.cabinetDescriptions = []
    }
    
    init(tail: String, cabinetDescriptions: [[String:UIImage?]]) {
        self.tail = tail
        self.cabinetDescriptions = cabinetDescriptions
    }
}

final class DataManager {
    
    //Properties
    static let shared:DataManager = {
        let instance = DataManager()
        
        //test data ----- DELETE
        let dataPointOne = AircraftInteriorConfiguration(tail: "N255DV", cabinetDescriptions: [["Water":#imageLiteral(resourceName: "IMG_3168.JPG")]])
        instance.data.append(dataPointOne)
        //test data ----- DELETE
        
        return instance
    }()

    
    var data:[AircraftInteriorConfiguration] = []{
        didSet{
            self.tails = []
            for config in data {
                self.tails.append(config.tail)
            }
        }
    }
    var tails:[String] = []
    
    //Functions
    func add(configuration:AircraftInteriorConfiguration){
        self.data.append(configuration)
    }
    
    func replace(withConfiguration configuration:AircraftInteriorConfiguration, atIndex index:Int){
        self.data[index] = configuration
    }
    
    func delete(configurationAtIndex index:Int){
        self.data.remove(at: index)
    }
    
    
    
    //Not used.  May need to delete
//    func cabinetNameAndImageForTail(_ tail: String, atIndex index: Int) -> [String:UIImage?]?{
//        
//        if self.data.count != 0 {
//            
//            for config in self.data{
//                if config.tail == tail{
//                    return config.cabinetDescriptions[index]
//                }
//            }
//        }
//        return nil
//    }
    
}

class TailsTableViewController: UITableViewController {

    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard self.dataManager.tails.count != 0 else {return 0}
        return dataManager.tails.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tailCell", for: indexPath)

        let tail = self.dataManager.tails[indexPath.row]
        
        (cell as? TailTableViewCell)?.tailLabel.text = tail

        return cell
    }

    
    func update(){
        self.tableView.reloadData()
    }
    
    
    @IBAction func unwindFromEdit(sender: UIStoryboardSegue){
        self.update()
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
            self.dataManager.delete(configurationAtIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
    
            if segue.identifier == "editTailSegue" {
    
                let cell = (sender as? TailTableViewCell)
                let row = self.tableView.indexPath(for: cell!)?.row
                
                (segue.destination as? EditTailsViewController)?.passedTailRow = row
            }
    
            if segue.identifier == "addTailSegue" {
    
                (segue.destination as? EditTailsViewController)?.passedTailRow = nil
            }

        }
}
