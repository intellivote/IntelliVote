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
    
    /*Username Field Outlet */
    @IBOutlet weak var registerUserNameField: HoshiTextField!
    /*Password Field Outlet */
    @IBOutlet weak var registerPasswordField: HoshiTextField!
    /*Address Field Outlet */
    @IBOutlet weak var registerAddressField: HoshiTextField!
    /*City Field Outlet */
    @IBOutlet weak var registerCityField: HoshiTextField!
    /*County Field Outlet */
    @IBOutlet weak var registerCountyField: HoshiTextField!
    /*Zipcode Field Outlet */
    @IBOutlet weak var registerZipField: HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.layer.cornerRadius = 15
    }
    
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    /*This function registers the user with Heroku */
    @IBAction func onRegister(_ sender: Any) {
        /*Create a PF User. Save information aquired from the text fields */
        let user = PFUser()
        user.username = registerUserNameField.text
        user.password = registerPasswordField.text
        user["address"] = registerAddressField.text
        user["city"] = registerCityField.text
        user["county"] = registerCountyField.text
        user["zip"] = registerZipField.text

        /*Sign up the user in the background */
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
