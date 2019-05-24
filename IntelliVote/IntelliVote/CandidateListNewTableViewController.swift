//
//  CandidateListNewTableViewController.swift
//  IntelliVote
//
//  Created by Dean Pektas on 5/23/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CandidateListNewTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let APIKey = "AIzaSyDaBUfYL90FvXCO9bfQ-7qJYON-d2yiDwo"
  
    var candidates = [[String: Any]]()
    
    var contests =  [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        loadCandidates()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    
    func loadCandidates() {
        let part1CivicsURL = "https://www.googleapis.com/civicinfo/v2/voterinfo?address="
        let currentUser = PFUser.current()
        let currentUserAddress = currentUser?["address"] as! String
        
        let modifiedUserAddress = currentUserAddress.replacingOccurrences(of: " ", with: "+", options: .literal
            , range: nil)
        let part2CivicsURL = "+NY&electionId=2000&officialOnly=true&returnAllAvailableData=true&fields=contests%2CdropOffLocations%2CearlyVoteSites%2Celection%2Ckind%2CmailOnly%2CnormalizedInput%2CotherElections%2CpollingLocations%2CprecinctId%2Csegments%2Cstate&key="
        
        
        let stringCivicsURL = part1CivicsURL + modifiedUserAddress + part2CivicsURL + self.APIKey
        
        let url = URL(string:stringCivicsURL )!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.contests = dataDictionary["contests"] as! [[String: Any]]
                let firstRow = self.contests[0]
                let office = firstRow["office"] as! String
                
                
                self.candidates = firstRow["candidates"] as! [[String: Any]]
                self.tableView.reloadData()
                
//                let firstCandidate = self.candidates[0]
//                let firstCandidateName = firstCandidate["name"] as! String
//
//                let firstCandidateParty =  firstCandidate["party"] as! String
//
//                let firstCandidatePhotoUrl = firstCandidate["photoUrl"] as! String
//                print("Candidate Name:")
//                print(firstCandidateName)
//                print("Candidate Party:")
//                print(firstCandidateParty)
//
                
                
                
                
                //let candidatesV1 = contests
                //                let candidatesV1 = contests
                //                self.candidates = [contests[3]]
                //                print(self.candidates.count)
                
                
                //                let candidateInfo = self.contests["candidates"] as? [[String:Any]]
                //                let candidateName = candidateInfo[4] as! [String: Any]
                //                print(candidateName)
                }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let myCount = candidates.count
        return myCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let specificCandidate = self.candidates[indexPath.row]
        //cell.textLabel!.text = specificCandidate["name"] as! String
    
        return cell
        
        
//        print("heyooo")
//        let cell = UITableViewCell()
//        let specificCandidate = candidates[indexPath.row]
//        print("My candidate:\n")
//        print(specificCandidate)
//        let candName = specificCandidate["name"] as! String
//
//        cell.textLabel!.text = candName
//
//        return cell
        
        
        
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("heyooo")
//
//        let specificCandidate = candidates[indexPath.row]
//        let candName = specificCandidate["name"] as! String
//
//        cell.textLabel!.text = candName
//
//        return cell
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
