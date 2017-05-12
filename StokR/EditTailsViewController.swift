//
//  EditTailsViewController.swift
//  StokR
//
//  Created by Christopher Martin on 5/11/17.
//  Copyright © 2017 Christopher Martin. All rights reserved.
//

import UIKit

class EditTailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tailsTextField: UITextField!

    var passedTail:String?
    var passedRow:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tailsTextField.delegate = self
       
        self.tailsTextField.text = self.passedTail
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        self.tailsTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.passedTail = self.tailsTextField.text
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
