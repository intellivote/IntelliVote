//
//  LoginViewController.swift
//  IntelliVote
//
//  Created by Dean Pektas on 4/24/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import TextFieldEffects
import Parse

class LoginViewController: UIViewController {
    /*Login Button Outlet */
    @IBOutlet weak var loginButton: UIButton!
    /*Register Button Outlet */
    @IBOutlet weak var registerButton: UIButton!
    /*Username Field Outlet */
    @IBOutlet weak var usernameField: HoshiTextField!
    /*Pasword Field Outlet */
    @IBOutlet weak var passwordField: HoshiTextField!
    /*Author Label */
    @IBOutlet weak var authLabel: UILabel!
    

    /*Function that is loaded as soon as app enters this screen */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.layer.cornerRadius = 15
        self.registerButton.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
    }
    /*Hides keyboard */
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    /*Logs user into the System */
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSuccessSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
                    self.authLabel.text = "Invalid username/password combination"
                
            }
        }
    }
    
    
    
        
    
    
    

}
