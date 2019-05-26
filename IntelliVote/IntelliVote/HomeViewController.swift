//
//  HomeScreenViewController.swift
//  IntelliVote
//
//  Created by Mohanad Osman on 4/24/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    /*Outlet for welcome label */
    @IBOutlet weak var nameLabel: UILabel!

    /*This function is called as soon as the User Logs In. The username of the current PFUser
     is extracted to set the welcome label text*/
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.current()
        nameLabel.text = currentUser?["username"] as! String
        
    }
    
    /*Logs user out of the app */
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginView")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginViewController
    }

}
