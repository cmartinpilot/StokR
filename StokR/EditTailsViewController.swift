//
//  EditTailsViewController.swift
//  StokR
//
//  Created by Christopher Martin on 5/11/17.
//  Copyright © 2017 Christopher Martin. All rights reserved.
//

import UIKit

class EditTailsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //Properties
    
    @IBOutlet weak var tailsTextField: UITextField!

    @IBOutlet weak var cabinetsTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!

    var cellOfTappedImageView:UITableViewCell? = nil
    
    var passedTailRow:Int?
    
    let dataManager:DataManager = DataManager.shared
    
    var cachedConfig:AircraftInteriorConfiguration = AircraftInteriorConfiguration()
    
    let imagePicker:UIImagePickerController = UIImagePickerController()
    
    //To iterate through the textfields and resign first responder when touching Save
    var textFields:[UITextField] = []
    
    
    
    
    
    //Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Turn off cell selection
        self.tableView.allowsSelection = false
        
        //Set the tailTextField delegate
        tailsTextField.delegate = self
       
        if let row = self.passedTailRow{
            self.cachedConfig = self.dataManager.data[row]
            self.tailsTextField.text = self.cachedConfig.tail
        }
        
        //Set the picker delegate
        self.imagePicker.delegate = self
    }

        
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        //Stop editing and update cache if needed before adding new cabinet
        for field in self.textFields{
            if field.isFirstResponder{field.resignFirstResponder()}
        }
        if self.tailsTextField.isFirstResponder{self.tailsTextField.resignFirstResponder()}
        //
        
        self.cachedConfig.cabinetDescriptions.append(["":#imageLiteral(resourceName: "AddImage")])
        
        self.tableView.reloadData()
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        
        //Capture the cell of the tapped imageView
        if sender.state == .ended{
            if let imageView = sender.view{
                if let cell = (imageView.superview?.superview as? CabinetCell){
                    self.cellOfTappedImageView = cell
                }
            }
        }
        
        self.configureAndPresentImagePicker()
    }
    
    func configureAndPresentImagePicker(){
        self.imagePicker.allowsEditing = false
        self.present(self.imagePicker, animated: true) {}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage]{
            if let cell = self.cellOfTappedImageView as? CabinetCell{
                cell.thumbImageView.image = (image as? UIImage)
                self.updateCache(fromCell: cell)
            }
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        for field in self.textFields{
            if field.isFirstResponder{field.resignFirstResponder()}
        }
        if self.tailsTextField.isFirstResponder{self.tailsTextField.resignFirstResponder()}
        
        //User tapped "Save" because back button does not invoke prepare(forSegue)
        if let row = self.passedTailRow{
            //If we passed a row, this is an edited tail and we need to update the data
            self.dataManager.replace(withConfiguration: self.cachedConfig, atIndex: row)
        }else{
            //Otherwise, we have a new tail
            self.dataManager.add(configuration: self.cachedConfig)
        }
        
    }
 
    
    // MARK: - Table View Delegate
    
    // MARK: - Table View Data Source
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let config = self.cachedConfig
        return config.cabinetDescriptions.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cabinetCell")!

        
        let config = self.cachedConfig
        
        for (descript, image) in config.cabinetDescriptions[indexPath.row]{
            
            //Cabinet Name textField setup
            (cell as! CabinetCell).cabinetNameTextField.delegate = self
            (cell as! CabinetCell).cabinetNameTextField.text = descript
            let alreadyIncluded = self.textFields.contains(where: { (element) -> Bool in
                if ((cell as! CabinetCell).cabinetNameTextField) == element{
                    return true
                }else{return false}
            })
            if !alreadyIncluded {self.textFields.append((cell as! CabinetCell).cabinetNameTextField)}
            
            //Image setup
            (cell as! CabinetCell).thumbImageView.image = image
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(EditTailsViewController.imageTapped(_:)))
            (cell as! CabinetCell).thumbImageView.addGestureRecognizer(recognizer)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.cachedConfig.cabinetDescriptions.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let cell = (textField.superview?.superview as? CabinetCell){
            self.updateCache(fromCell: cell)
        }else{
        
            if textField == self.tailsTextField {
                if let text = textField.text{
                    self.cachedConfig.tail = text
                }else{
                    self.cachedConfig.tail = ""
                }
            }
        }
    }

    
    
    func updateCache(fromCell cell:UITableViewCell){
        
        if let cell = (cell as? CabinetCell){
            let cabinetIndex = self.tableView.indexPath(for: cell)?.row
            let cabinetImage = cell.thumbImageView.image
            if let cabinetName:String = cell.cabinetNameTextField.text{
                self.cachedConfig.cabinetDescriptions[cabinetIndex!] = [cabinetName:cabinetImage]
            }else{
                let cabinetName:String = ""
                self.cachedConfig.cabinetDescriptions[cabinetIndex!] = [cabinetName:cabinetImage]
            }
        }
    }
}
