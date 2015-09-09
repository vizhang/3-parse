//
//  ChatroomViewController.swift
//  3-parse
//
//  Created by Victor Zhang on 9/9/15.
//  Copyright (c) 2015 Victor Zhang. All rights reserved.
//

import UIKit

class ChatroomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        //GET CURRENT USER
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            // Do stuff with the user
            println("do stuff!")
        } else {
            // Show the signup or login screen
            println("something is wrong and we shoudln't be here...")
        }
        
        //Refresh Messages
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "refreshMessages", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = self.messages {
            return self.messages!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        let message = messages![indexPath.row] as PFObject
        let something = message.objectForKey("text") as! String
        cell.messageLabel?.text = something

        let username = message.objectForKey("user") as? PFUser
        if let user = username {
            cell.userLabel?.text = username?.username
            
        }
        
        
        return cell
    }
    
    
    @IBAction func sendPressed(sender: AnyObject) {
        //Try to store in parse
        var message = PFObject(className:"Message")
        message["text"] = self.messageTextField.text
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("message was successfully sent")
            } else {
                println("error in sending message: \(error?.description)")
            }
        }
        
        //Clear message after it send
        self.messageTextField.text = ""
        
    }

    func refreshMessages() {
        //GET FROM PARSE
        var query = PFQuery(className:"Message")
        query.orderByDescending("createdAt")
        query.includeKey("user")

        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                //println("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                self.messages = objects as? [PFObject]
                
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                        println(object.description)
                    }
                }
                
                //RELOAD TABLE
                self.tableView.reloadData()
                
            } else {
                // Log details of the failure
                println("refreshMessages error: \(error!) \(error!.userInfo!)")
            }
        }

    }
    

}
