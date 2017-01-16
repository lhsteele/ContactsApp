//
//  Contact.swift
//  ContactsApp_Thinkful
//
//  Created by Lisa Steele on 1/15/17.
//  Copyright © 2017 Lisa Steele. All rights reserved.
//

import UIKit

//This is a model class created to hold the information of each contact. The Contact class defined below acts as a container that holds the name and phoneNumber of a contact.

//Having a Swift class inherit from NSObject isn't required, but will ensure you can access the class from Objective-C code.

//Defining the variables name and phoneNumber as optionals means you can create a contact with only one or the other.

//Both variables are optionals, so we don't need to initialize (but we have here).

//Because we gave both variables a default property of nil in the initializer, if we create a new Contact object with just a name, the phoneNumber variable will default to nil. This gives us the flexibility of creating a Contact with limited information, while retaining the safety of optionals.

class Contact: NSObject {
    var name: String?
    var phoneNumber: String?
    
    init(name: String? = nil, phoneNumber: String? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        super.init()
    }
}
