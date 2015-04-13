//
//  MapViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var dictionaryTableView: UITableView!

    var tableData = ["one": "two", "three":"four"]
    let cellId = "jammie"
    
    @IBOutlet weak var keyInput: UITextField!
    @IBOutlet weak var valueInput: UITextField!
    
    var keys:[String] { //computed property
        get{
            return Array(tableData.keys)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        keyInput.delegate = self
        valueInput.delegate = self
        self.dictionaryTableView.delegate = self
        self.dictionaryTableView.dataSource = self
        self.dictionaryTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        /*
        TODO three: Add TWO text views and a table view to this view controller, either using code or storybaord. Accept keyboard input from the two text views. When the 'return' button is pressed on the SECOND text view, add the text view data to a dictionary. The KEY in the dictionary should be the string in the first text view, the VALUE should be the second.
       */
        
        
        /*TODO four: Make this class a UITableViewDelegate and UITableViewDataSource that supply this table view with cells that correspond to the values in the dictionary. Each cell should print out a unique pair of key/value that the map contains. When a new key/value is inserted, the table view should display it.
        TODO five: Make the background of the text boxes in this controller BLUE when the keyboard comes up, and RED when it goes down. Start with UIKeyboardWillShowNotification and NSNotificationCenter.
        */
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return keys.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("jammie", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        let key = keys[indexPath.row]
        cell.textLabel?.text = key + ": \(tableData[ key ]!)"
        return cell
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHideNotification:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShowNotification:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShowNotification(notification:NSNotification){
        keyInput.backgroundColor = UIColor.blueColor()
        valueInput.backgroundColor = UIColor.blueColor()
    }
    
    func keyboardDidShowNotification(notification:NSNotification){
        
    }
    
    func keyboardWillHideNotification(notification: NSNotification){
        keyInput.backgroundColor = UIColor.redColor()
        valueInput.backgroundColor = UIColor.redColor()
        tableData[keyInput.text!] = valueInput.text!
        keyInput.text? = ""
        valueInput.text? = ""
        self.dictionaryTableView.reloadData()
    }
    
    func keyboardDidHideNotification(notification: NSNotification){
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
