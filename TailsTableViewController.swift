//
//  TailsTableViewController.swift
//  StokR
//
//  Created by Christopher Martin on 5/11/17.
//  Copyright © 2017 Christopher Martin. All rights reserved.
//

import UIKit

class TailsTableViewController: UITableViewController {

    var data = ["N279DV", "N716DV", "N606MC", "N522AC", "N255DV"]
    
    
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tailCell", for: indexPath)

        let tail = self.data[indexPath.row]
        
        (cell as? TailTableViewCell)?.tailLabel.text = tail

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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
    
            if segue.identifier == "editTailSegue" {
    
                let cell = (sender as? TailTableViewCell)
                let row = self.tableView.indexPath(for: cell!)?.row
                let tail = cell?.tailLabel.text
    
                (segue.destination as? EditTailsViewController)?.passedTail = tail
                (segue.destination as? EditTailsViewController)?.passedRow = row
            }
    
            if segue.identifier == "addTailSegue" {
    
                let editVC = (segue.destination as? EditTailsViewController)
                editVC?.passedRow = self.data.count
            }

        }
}
