//
//  ChatViewController.swift
//  Exercise3
//
//  Created by John Boggs on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let CHAT_CELL_IDENTIFIER = "ChatCellIdentifier"
    var messages: [String] = []
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    @IBAction func sendButtonPressed(sender: AnyObject) {
        var message = PFObject(className:"Message")
        message["text"] = chatTextField.text
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                println("message save success")
            } else {
                println("message save fail")
            }
        }
        println("send button pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "fetch", userInfo: nil, repeats: true)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(self.CHAT_CELL_IDENTIFIER) as UITableViewCell
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
    
    func fetch() {
        println("fetching...")
        var query = PFQuery(className:"Message")
        query.orderByDescending("createdAt")
//        query.whereKey("playerName", equalTo:"Sean Plott")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) messages.")
                // Do something with the found objects
                
                self.messages = objects.map({
                    object in object["text"]! as String
                })
                
                self.tableView.reloadData()
//                println(self.messages)
                
//                for object in objects {
//                    NSLog("%@", object.objectId)
//                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

}
