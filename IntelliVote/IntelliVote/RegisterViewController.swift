//
//  RegisterViewController.swift
//  IntelliVote
//
//  Created by Dean Pektas on 4/24/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import TextFieldEffects
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
