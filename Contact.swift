//
//  Contact.swift
//  ContactsApp_Thinkful
//
//  Created by Lisa Steele on 1/15/17.
//  Copyright © 2017 Lisa Steele. All rights reserved.
//

import UIKit

class Contact: NSObject {
    var name: String?
    var phoneNumber: String?
    
    init(name: String? = nil, phoneNumber: String? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        super.init()
    }
}
