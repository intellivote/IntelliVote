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
import CoreLocation

class VotingLocationViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
//class VotingLocationViewController: UIViewController {

    

    @IBOutlet weak var voterAddressField: UITextField!
    
    @IBOutlet weak var pollLocationMap: MKMapView!
    
    var vote = [[String:Any]]()

//    var locationName: String = ""
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
    }
    
    func getPollLocation() {
        var locationName = ""
        
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
                locationName = addr["locationName"] as! String
                let part1GeoURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
                let modifiedLocationName = locationName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                
                let part2GeoURL = "+NY&key="
                self.stringGeoURL = part1GeoURL + modifiedLocationName + part2GeoURL + self.APIKey
                
                
                
                let geoUrl = URL(string:self.stringGeoURL )!
                let requestGeo = URLRequest(url: geoUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                let sessionGeo = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                let taskGeo = sessionGeo.dataTask(with: requestGeo) { (dataGeo, responseGeo, errorGeo) in
                    // This will run when the network request returns
                    if let errorGeo = errorGeo {
                        print(errorGeo.localizedDescription)
                    } else if let dataGeo = dataGeo {
                        let dataDictionaryGeo = try! JSONSerialization.jsonObject(with: dataGeo, options: []) as! [String: Any]
                        
//                        print(dataDictionaryGeo)
                        
                        let results = dataDictionaryGeo["results"] as! [[String:Any]]
                        print("hi")
                        let resultsBasic = results[0]
                        
                        let geometry = resultsBasic["geometry"] as! [String:Any]

                        let locationCoordinates = geometry["location"] as! [String:Any]
                        
                        
                        let lat = locationCoordinates["lat"] as! Double
                        let long = locationCoordinates["lng"] as! Double
                        
                        
                        let centerLocation = CLLocation(latitude: lat, longitude: long)
                        self.goToLocation(location: centerLocation)
                        
                        
                        //                let voteinfo = self.vote[0]
                        //                let addr = voteinfo["address"] as! [String: Any]
                        //                self.locationName = addr["locationName"] as! String
                        //
                        //                print(self.locationName)
                        
                        
                    }

                }
                taskGeo.resume()

            }
        }
        
        task.resume()

       
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        pollLocationMap.setRegion(region, animated: false)
    }
    
    


    
    


}
