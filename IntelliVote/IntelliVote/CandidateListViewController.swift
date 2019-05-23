//
//  CandidateListViewController.swift
//  IntelliVote
//
//  Created by Yaniv Bronshtein on 5/23/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse
class CandidateListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    let APIKey = "AIzaSyDaBUfYL90FvXCO9bfQ-7qJYON-d2yiDwo"
    
    var contests = [[String : Any]]()
    
    var candidates = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        loadCandidates()
        
        self.collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
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
                self.candidates = [self.contests[3] ]

                
                
//                let candidateInfo = self.contests["candidates"] as? [[String:Any]]
//                let candidateName = candidateInfo[4] as! [String: Any]
//                print(candidateName)
                
            }
        }
            task.resume()
            
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return contests.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "candidateViewCell", for: indexPath) as! CandidateCollectionViewCell
        let candidate = candidates[indexPath.row]
        print(candidate)
//        let candidateName = self.candidates["name"] as! String
//        let candidateParty = self.candidates["party"] as! String
//        let candidatePhotoURL = self.candidates["photoUrl"] as! String
        
        
        

        return cell
    }

}
