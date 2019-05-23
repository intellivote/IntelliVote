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

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var usernameField: HoshiTextField!
    
    @IBOutlet weak var passwordField: HoshiTextField!
    
    @IBOutlet weak var authLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.layer.cornerRadius = 15
        self.registerButton.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
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
    
    
    
        
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
