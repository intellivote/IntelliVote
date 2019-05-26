//
//  AppDelegate.swift
//  IntelliVote
//
//  Created by Yaniv Bronshtein on 4/24/19.
//  Copyright © 2019 Yaniv Bronshtein. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    /*Sets up app in Heroku */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize Parse
        // Set applicationId and server based on the values in the Heroku settings.
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "vote"
                configuration.server = "https://intellivote.herokuapp.com/parse"
            })
        )
        if PFUser.current() != nil {
            let main = UIStoryboard(name: "Main",bundle: nil)
            let voterNavigationController = main.instantiateViewController(withIdentifier: "VoterNavigationController")
            window?.rootViewController = voterNavigationController
        }
        
        return true
    }
    

    
}

