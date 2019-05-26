//
//  VotingLocationViewController.swift
//  IntelliVote
//
//  Created by Yaniv Bronshtein on 4/29/19.
//  Copyright © 2019 Dean Pektas. All rights reserved.
//
//

import UIKit
import Parse
import MapKit
import CoreLocation
import TextFieldEffects

class VotingLocationViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    /**TextField defaulted to address of current user. Can be changed to any address */
    @IBOutlet weak var voterAddressField: UITextField!
    /**Outlet for find location button */
    @IBOutlet weak var findLocationButton: UIButton!
    /*Latitude coordinate variable */
    var lat: Double = 0.0
    /*Longitude coordinate Variable */
    var long: Double = 0.0
    /*Map View for poll location */
    @IBOutlet weak var pollLocationMap: MKMapView!
    /*Poll location name */
    var votingLocationName: String = ""
    /*Dictionary for voting information */
    var vote = [[String:Any]]()
    /*API key used to access the API */
    let APIKey = "AIzaSyDaBUfYL90FvXCO9bfQ-7qJYON-d2yiDwo"
    /*Civic Information API URL */
    var stringCivicsURL: String = ""
    /*Geocoding APi URL */
    var stringGeoURL: String = ""
    
    /*This function is called as soon as the VotingLocationViewController is entered
     Here, we set the delegate and call getUserAddress() to set a default value for the address Field*/
    override func viewDidLoad() {
        super.viewDidLoad()
        pollLocationMap.delegate = self
        self.voterAddressField.text = getUserAddress()
        self.findLocationButton.layer.cornerRadius = 15
    }
    
    /**This function is used to hide the keyboard */
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    /**When the "Find Location" button is tapped, the getPollLocation() function is called */
    @IBAction func onFindLocation(_ sender: Any) {
        getPollLocation()
        
    }
    
    /**This function first makes an API call to the Google Civic Information API to
     retrieve the poll location associated with the address and then sends the information to the Google GeoCoding API to retrieve the global coordinates of the poll location
     The coordinates are then used to display directions using apple maps and the general map of the area.
     */
    func getPollLocation() {
        
        /*Build the API call URL for the Google Civic Information API Call */
        let part1CivicsURL = "https://www.googleapis.com/civicinfo/v2/voterinfo?address="
        let voterAddress = voterAddressField.text!
        let modifiedVoterAddress = voterAddress.replacingOccurrences(of: " ", with: "+", options: .literal
            , range: nil)
        let part2CivicsURL = "+NY&electionId=2000&officialOnly=true&returnAllAvailableData=true&fields=contests%2CdropOffLocations%2CearlyVoteSites%2Celection%2Ckind%2CmailOnly%2CnormalizedInput%2CotherElections%2CpollingLocations%2CprecinctId%2Csegments%2Cstate&key="
        self.stringCivicsURL = part1CivicsURL + modifiedVoterAddress + part2CivicsURL + self.APIKey
        
        let url = URL(string:stringCivicsURL )!
        
        /*Create the network request */
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        /*Start a session */
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        /*Create a task to scrape the JSON */
        let task = session.dataTask(with: request) { (data, response, error) in
            
            /*Print any errors */
            if let error = error {
                print(error.localizedDescription)
            
            } else if let data = data {
                /*Store contents of JSON into dataDictionary */
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                /*Extract the String Voting Location Name from the JSON */
                self.vote = dataDictionary["pollingLocations"] as! [[String: Any]]
                let voteinfo = self.vote[0]
                let addr = voteinfo["address"] as! [String: Any]
                self.votingLocationName = addr["locationName"] as! String
                
                /*Replace the spaces in the address with '+' to build the URL */
                let modifiedVotingLocationName = self.votingLocationName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                
                /*Build the URL for the Google GeoCoding API call */
                let part1GeoURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
                let part2GeoURL = "+NY&key="
                self.stringGeoURL = part1GeoURL + modifiedVotingLocationName + part2GeoURL + self.APIKey
                
                let geoUrl = URL(string:self.stringGeoURL )!
                
                /*Create a network request */
                let requestGeo = URLRequest(url: geoUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                
                /*Start a geoCoding Session */
                let sessionGeo = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                
                /*Start a Geo Task */
                let taskGeo = sessionGeo.dataTask(with: requestGeo) { (dataGeo, responseGeo, errorGeo) in
                    
                    if let errorGeo = errorGeo {
                        print(errorGeo.localizedDescription)
                    } else if let dataGeo = dataGeo {
                        
                        /*Store Contents of GeoCoding API in dataDictionaryGeo */
                        let dataDictionaryGeo = try! JSONSerialization.jsonObject(with: dataGeo, options: []) as! [String: Any]
                        
                        /*Extract the Latitude and Longitude Global coordinates from the JSON */
                        let results = dataDictionaryGeo["results"] as! [[String:Any]]
                        let resultsBasic = results[0]
                        let geometry = resultsBasic["geometry"] as! [String:Any]
                        let locationCoordinates = geometry["location"] as! [String:Any]
                        self.lat = locationCoordinates["lat"] as! Double
                        self.long = locationCoordinates["lng"] as! Double
                        
                        /*Set the center location to be passed to the goToLocation() function */
                        let centerLocation = CLLocation(latitude: self.lat, longitude: self.long)
                        self.goToLocation(location: centerLocation)
                    }
                }
                taskGeo.resume()
            }
        }
        task.resume()
    }
    
    /*This function uses the Embedded Map Kit to set the locale and then calls addPin()
     to create a pin for the specific location*/
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        pollLocationMap.setRegion(region, animated: false)
        addPin()
    }
    
    /*This function drops a pin on the map and labels the voting location name */
    func addPin() {
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
        annotation.coordinate = locationCoordinate
        annotation.title = self.votingLocationName
        pollLocationMap.addAnnotation(annotation)
    }
    
    /*This function extracts the current PFUser's address to be set as the default value for the voter Address field */
    func getUserAddress() ->String {
        let currentUser = PFUser.current()
        return currentUser?["address"] as! String
    }
    
    /*This function opens Apple Maps as soon as the pin is clicked */
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let appleMapsURL = URL(string: "http://maps.apple.com/?q=\(self.lat),\(self.long)") else { return }
        UIApplication.shared.open(appleMapsURL, options: [:], completionHandler: nil)
    }
    
}
