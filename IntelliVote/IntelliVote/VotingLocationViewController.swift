//
//  VotingLocationViewController.swift
//  IntelliVote
//
//  Created by Yaniv Bronshtein on 4/29/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit

class VotingLocationViewController: UIViewController {

    @IBOutlet weak var pollLocation: UITextView!
    @IBOutlet weak var voterAddressField: UITextField!
    
    
    var vote = [[String:Any]]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let part1URL = "https://www.googleapis.com/civicinfo/v2/voterinfo?address="
        
        let part2URL = "+NY&electionId=2000&officialOnly=true&returnAllAvailableData=true&fields=contests%2CdropOffLocations%2CearlyVoteSites%2Celection%2Ckind%2CmailOnly%2CnormalizedInput%2CotherElections%2CpollingLocations%2CprecinctId%2Csegments%2Cstate&key=AIzaSyB9-Z4TVPVAvaqu8p0_Q-iyMBcDLuNTZxo"
        
        let myAddress = "2411 21st Ave. Astoria"
        
        let modifiedAddress = myAddress.replacingOccurrences(of: " ", with: "+", options: .literal
            , range: nil)
        let stringURL = part1URL + modifiedAddress + part2URL
        
        
        
        let url = URL(string:stringURL )!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.vote = dataDictionary["pollingLocations"] as! [[String: Any]]
                let voteinfo = self.vote[0]
                let addr = voteinfo["address"] as! [String: Any]
                let locationName = addr["locationName"] as? String
                self.pollLocation.text = locationName
                print(locationName)
                //let nestedDictionary = self.vote["address"] as? [String:Any]
                
                
                
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
        
    }

}
