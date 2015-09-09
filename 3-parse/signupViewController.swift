//
//  signupViewController.swift
//  3-parse
//
//  Created by Victor Zhang on 9/9/15.
//  Copyright (c) 2015 Victor Zhang. All rights reserved.
//

import UIKit

class signupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func signupPressed(sender: AnyObject) {
        var user = PFUser()
        user.username = self.emailTextField.text
        user.password = self.passwordTextField.text
        user.email = self.emailTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                println(errorString)
                let alert = UIAlertView()
                alert.title = "Sign-up failed."
                alert.message = "Something funky came up. " + "\(errorString)"
                alert.addButtonWithTitle("OK")
                alert.show()
                
            } else {
                println("segue to new logged-in state")
                self.performSegueWithIdentifier("signupTOchatroom", sender: nil)
            }
        }

        
    }
    
    
}


