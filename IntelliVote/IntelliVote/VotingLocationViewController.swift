//
//  VotingLocationViewController.swift
//  IntelliVote
//
//  Created by Yaniv Bronshtein on 4/29/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//

import UIKit
import Parse
import MapKit
class VotingLocationViewController: UIViewController, MKMapViewDelegate {
//class VotingLocationViewController: UIViewController {

    

    @IBOutlet weak var voterAddressField: UITextField!
    
    @IBOutlet weak var pollLocationMap: MKMapView!
    
    var vote = [[String:Any]]()
    
    var locationName: String = ""
    let APIKey = "AIzaSyDaBUfYL90FvXCO9bfQ-7qJYON-d2yiDwo"
    
    
    var stringCivicsURL: String = ""
    var stringGeoURL: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pollLocationMap.delegate = self
        voterAddressField.text = "201-08 23rd. Ave. Bayside NY"
        

    }
    
    
    
    @IBAction func onFindLocation(_ sender: Any) {
        getPollLocation()
        getCoordinates()
    }
    
    func getPollLocation() {
        let part1CivicsURL = "https://www.googleapis.com/civicinfo/v2/voterinfo?address="
        let myAddress = "201-08 23rd. Ave. Bayside NY"
        let modifiedAddress = myAddress.replacingOccurrences(of: " ", with: "+", options: .literal
            , range: nil)
        let part2CivicsURL = "+NY&electionId=2000&officialOnly=true&returnAllAvailableData=true&fields=contests%2CdropOffLocations%2CearlyVoteSites%2Celection%2Ckind%2CmailOnly%2CnormalizedInput%2CotherElections%2CpollingLocations%2CprecinctId%2Csegments%2Cstate&key="
        
        
        self.stringCivicsURL = part1CivicsURL + modifiedAddress + part2CivicsURL + self.APIKey
        
        let url = URL(string:stringCivicsURL )!
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
                self.locationName = addr["locationName"] as! String
                
                print(self.locationName)
                
            }
        }
        task.resume()
    }
    
    
    func getCoordinates() {
        let part1GeoURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let modifiedLocationName = self.locationName.replacingOccurrences(of: " ", with: "+", options: .literal
                            , range: nil)
        let part2GeoURL = "+NY&key="
        
        self.stringGeoURL = part1GeoURL + modifiedLocationName + part2GeoURL + self.APIKey
        
        print(stringGeoURL)
        
        
        let url = URL(string:self.stringGeoURL )!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                print(dataDictionary)
                
//                self.vote = dataDictionary["pollingLocations"] as! [[String: Any]]
//                let voteinfo = self.vote[0]
//                let addr = voteinfo["address"] as! [String: Any]
//                self.locationName = addr["locationName"] as! String
//
//                print(self.locationName)
                
            }
        }
        task.resume()
        
    }
    

    
    

    

    
    


}
