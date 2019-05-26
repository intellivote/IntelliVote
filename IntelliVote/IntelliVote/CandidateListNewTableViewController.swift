//
//  CandidateListNewTableViewController.swift
//  IntelliVote
//
//  Created by Yaniv Bronshtein  on 5/23/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CandidateListNewTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /*Creates outlet for table view */
    @IBOutlet weak var tableView: UITableView!
    /*API Key for access to Google API's */
    let APIKey = "AIzaSyDaBUfYL90FvXCO9bfQ-7qJYON-d2yiDwo"
    /*Dictionary to stores candidates */
    var candidates = [[String: Any]]()
    /*Dictionary to store all elections */
    var contests =  [[String: Any]]()
    
    /*This function is called as soon as the app enters the screen. The dataSource and delegate are insantiated and loadCandidates() is called to get the candidates in the local election */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        loadCandidates()
        
    }

    /* This functions makes a call to the Civic Information API to extract the candidate Information  */
    func loadCandidates() {
        /*Get address from current user */
        let currentUser = PFUser.current()
        let currentUserAddress = currentUser?["address"] as! String
        
        /*Build the Civic Information API call URL */
        let part1CivicsURL = "https://www.googleapis.com/civicinfo/v2/voterinfo?address="
        
        let modifiedUserAddress = currentUserAddress.replacingOccurrences(of: " ", with: "+", options: .literal
            , range: nil)
        let part2CivicsURL = "+NY&electionId=2000&officialOnly=true&returnAllAvailableData=true&fields=contests%2CdropOffLocations%2CearlyVoteSites%2Celection%2Ckind%2CmailOnly%2CnormalizedInput%2CotherElections%2CpollingLocations%2CprecinctId%2Csegments%2Cstate&key="
        let stringCivicsURL = part1CivicsURL + modifiedUserAddress + part2CivicsURL + self.APIKey
        
        let url = URL(string:stringCivicsURL )!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.contests = dataDictionary["contests"] as! [[String: Any]]
                let firstRow = self.contests[0]
                let office = firstRow["office"] as! String
                
                
                self.candidates = firstRow["candidates"] as! [[String: Any]]
                self.tableView.reloadData()

                }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myCount = candidates.count
        return myCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandidateViewCell") as! CandidateCell
        let specificCandidate = self.candidates[indexPath.row]
        let name = specificCandidate["name"] as! String
        let party = specificCandidate["party"] as! String
        
        cell.candidateName.text = name
        cell.candidateParty.text = party
        
        let baseUrl = specificCandidate["photoUrl"] as! String
        let imageUrl = URL(string: baseUrl)
        cell.candidatePhoto.af_setImage(withURL: imageUrl!)
        
        let firstRow = self.contests[0]
        let office = firstRow["office"] as! String
        cell.candidateOffice.text = office
        
        return cell
    }

}
