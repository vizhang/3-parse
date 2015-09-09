//
//  ViewController.swift
//  3-parse
//
//  Created by Victor Zhang on 9/9/15.
//  Copyright (c) 2015 Victor Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func loginPressed(sender: AnyObject) {
        if (self.emailTextField.text != "") && (self.passwordTextField.text != "") {
            PFUser.logInWithUsernameInBackground(self.emailTextField.text, password:self.passwordTextField.text) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    println("successfully logged in")
                    self.performSegueWithIdentifier("loginTOchatroom", sender: nil)

                } else {
                    println("not successfully logged in")
                    let alert = UIAlertView()
                    alert.title = "Nope."
                    alert.message = "That login wasn't quite right."
                    alert.addButtonWithTitle("OK")
                    alert.show()
                }
            }
        }

    }

}

