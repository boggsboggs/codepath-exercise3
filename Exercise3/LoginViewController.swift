//
//  LoginViewController.swift
//  Exercise3
//
//  Created by John Boggs on 2/18/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private let CHAT_SEGUE_ID = "chatSegueId"

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInButtonPressed(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(emailTextField.text, password:passwordTextField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                println("sign in successful")
                self.performSegueWithIdentifier(self.CHAT_SEGUE_ID, sender: self)
            } else {
                println("sign in failed")
            }
        }
    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        var user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        // other fields can be set just like with PFObject
//        user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                println("sign up successful")
                self.performSegueWithIdentifier(self.CHAT_SEGUE_ID, sender: self)
            } else {
                let errorString = error.userInfo!["error"] as NSString
                println("sign up failed")
            }
        }
    }
}
