//
//  HomeScreenViewController.swift
//  IntelliVote
//
//  Created by Dean Pektas on 4/24/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = PFUser.current()
        nameLabel.text = currentUser?["username"] as! String
        
    }
    

    

    
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginView")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginViewController
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
