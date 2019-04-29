//
//  RegisterViewController.swift
//  IntelliVote
//
//  Created by Dean Pektas on 4/24/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import TextFieldEffects
import Parse
class RegisterViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBOutlet weak var registerUserNameField: HoshiTextField!
    
    @IBOutlet weak var registerPasswordField: HoshiTextField!
    
    
    @IBOutlet weak var registerAddressField: HoshiTextField!
    
    @IBOutlet weak var registerCityField: HoshiTextField!
    
    @IBOutlet weak var registerCountyField: HoshiTextField!
    
    @IBOutlet weak var registerZipField: HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
        user.username = registerUserNameField.text
        user.password = registerPasswordField.text
        user["address"] = registerAddressField.text
        user["city"] = registerCityField.text
        user["county"] = registerCountyField.text
        user["zip"] = registerZipField.text

        user.signUpInBackground {
            (success, error) in
            if success {
                self.performSegue(withIdentifier: "registerSuccessSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    

}
