//
//  DetailViewController.swift
//  ContactsApp_Thinkful
//
//  Created by Lisa Steele on 1/13/17.
//  Copyright © 2017 Lisa Steele. All rights reserved.
//

import UIKit

//This file handles the code behind the Detail View Controller.

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    //Having UITextField properties instead of UILabel properties allows us to edit them.
    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    var contact: Contact?

    //When a user stops typing in the text field, it saves the value in the field text to our Contact object.
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameField {
            self.contact?.name = textField.text
        } else if textField == self.phoneNumberField {
            self.contact?.phoneNumber = textField.text
        }
    }
    
    //if let -- checks if the contact property has a value. If so, then we check the name and phoneNumber properties of that Contact for values. If found, we change the text of our labels to the information found.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.delegate = self
        self.phoneNumberField.delegate = self

        if let contact = self.contact {
            if let name = contact.name {
                self.nameField.text = name
            }
            if let phoneNumber = contact.phoneNumber {
                self.phoneNumberField.text = phoneNumber
            }
        }
        
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

}
