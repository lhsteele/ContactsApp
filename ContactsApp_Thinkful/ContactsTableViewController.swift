//
//  ContactsTableViewController.swift
//  ContactsApp_Thinkful
//
//  Created by Lisa Steele on 1/13/17.
//  Copyright © 2017 Lisa Steele. All rights reserved.
//

import UIKit


//This file tells the UITableViewController what data to display.

class ContactsTableViewController: UITableViewController {
    
    //This array has been created so the ContactsTableViewController will can an array of Contacts, rather than static data.
    var contacts: [Contact] = []
    
    
    //This changes the isEditing property of the table view to the opposite of it's current value. If the table view isn't editing, it == true. If it is editing, == false. Directly assigning 'true' or 'false' to isEditing wont' give you the animation effect that the setEditing function provides.
    func toggleEdit() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Contact objects and appending them to the contacts array.
        let jenny = Contact(phoneNumber: "867-5309")
        let rich = Contact(name: "Rich", phoneNumber: "888-888-8888")
        let mindy = Contact(name: "Mindy")
        
        self.contacts.append(jenny)
        self.contacts.append(rich)
        self.contacts.append(mindy)
        
        
        //This adds an "Edit" button to the navigation bar.
        //Can create a UIBarButtonItem with any text, but there is a built in type for "edit".
        //Target is the object that will respond when the button is pressed.
        //Action is the function to call on that object.
        //Selector specifies a call-back function.
        //last line (navigationItem.leftBar.....) specifies the button in the navigation bar on a per-view basis, so it doesn't show up in every view controller.
        let moveButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ContactsTableViewController.toggleEdit))
        navigationItem.leftBarButtonItem = moveButton
        
        
        //This lets us create new contacts.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ContactsTableViewController.addContact))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returns the number of sections. (1)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Returns the number of rows in the section.
    //In this example we've defined number of rows == number of objects in the contacts array defined at the top.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    //This function populates each cell with the name of a contact. First it retrieves the contact for this row from the array with self.contact[indexPath.row]. The indexPath object describes which section and row the cell we are currently creating belongs to. **If there were more than one section we would also need to reference the section.
    //Then we check the Contact object for a name property, and apply to the label if it exists. If not, we fill with "No Name".
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let contact = self.contacts[indexPath.row]
        
        if let name = contact.name {
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = "No Name"
        }
        
        return cell
    }
    
    //This is called when a segue is about to be performed and allows us to modify the destination view controller before it is shown on screen.
    //First retrieve the indexPath of the selected cell. Because segue is only called when a cell is selected, we know the sender is always going to be a UITableViewCell so we can force downcast it with as!. We also use the ! at the end of the indexPath to implicity unwrap the optional value it returns. **If there was more than one segue, to another view controller, this wouldn't be safe and we'd have to check which segue is being called first.
    //Next we retrieve the Contact object.
    //Then we retrieve our DetailViewController from the segue and 'as! DetailViewController' allows us to access it's properties.
    //Lastly, we assign the Contact object we received to the contact property of the destination.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
        let contact = self.contacts[indexPath.row]
        let destination = segue.destination as! DetailViewController
        destination.contact = contact
    }
    
    //Tells the tableView that we want cells to be editable. **If we don't want to edit certain cells, we would have to check the indexPath of those cells and return false.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Tells the tableView what types of edits are allowed.
    //First checks the editingStyle property to confirm the user is attempting a UITableViewEditingStyle.delete action (or .delete) -- enables the swipe to reveal 'Delete' button on the UITableView.
    //Inside the if we tell the TableView to delete rows at an aray of indexPaths. **There are other enumerations, such as .insert and the animation also has other options like .fade, .right.
    //self.contacts .... tells the contacts array to also delete the same contact from it's array of objects. Otherwise the numberOfRowsInSection is expecting a different number to the one that results here from the deletion.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    //Remove the contact from the array, then put it back in it's new spot.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let contactMoving = contacts.remove(at: fromIndexPath.row)
        contacts.insert(contactMoving, at: to.row)
    }
    
    
    //This means you don't get the minus/delete sign when in editing mode, on top of the 'Delete' button that appears when you swipe left. It checks to see if it's in editing mode, and returns .none if it is. If it isn't in editing mode, we return .delete, so the delete buttons will still show up when swiping left.
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    
    //We want the below to return falst, so the labels stay still when we're in editing mode. Otehrwise they would indent to make room for the minus/delete signs that are no longer there.
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    //When a Contacts object is updated, this will make sure the main view controller also updates. Without this, when you hit the 'Back' button, it will show the original data entered, not edited data.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    //First create a new Contact object and name it "New Contact".
    //Then add it to the contacts array.
    //Calculate the indexPath for the new row by taking the total number of objects in they array and subtracting one (to account for zero-indexing).
    //Insert a new row.
    func addContact() {
        let newContact = Contact(name: "New Contact")
        self.contacts.append(newContact)
        let newIndexPath = IndexPath(row: self.contacts.count - 1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}


 

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */



