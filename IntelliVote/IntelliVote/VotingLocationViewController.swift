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
    let civicsAPIKey = "AIzaSyAkTtnq_0xegDHjuYT0pdNDTtTgaJiBrZQ"
    let geoAPIKey = "AIzaSyBSeb1uTC15jOYPKijcDHhwQb254p2Hz2U"
    var stringCivicsURL: String = ""
    var stringGeoURL: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        pollLocationMap.delegate = self
        
        

    }
    
    
    
    @IBAction func onFindLocation(_ sender: Any) {


//                let modifiedLocationName = self.locationName.replacingOccurrences(of: " ", with: "+", options: .literal
//                    , range: nil)
//                let part2GeoURL = "+NY&key="
//
//                let stringGeoURL = part1GeoURL + modifiedLocationName + part2GeoURL + self.geoAPIKey
//
//                print(stringGeoURL)
//
//                //let mapCenter = CLLocationCoordinate2D(latitude: 37.783333, longitude: -122.416667)
////                let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
////                let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
////                // Set animated property to true to animate the transition to the region
////                self.pollLocationMap.setRegion(region, animated: false)
//
//
//
//            }
//        }
//        task.resume()
        
        getPollLocation()
        
        getCoordinates()
        
        
    }
    
    func getPollLocation() {
        let part1CivicsURL = "https://www.googleapis.com/civicinfo/v2/voterinfo?address="
        let myAddress = voterAddressField.text
        let modifiedAddress = myAddress!.replacingOccurrences(of: " ", with: "+", options: .literal
            , range: nil)
        let part2CivicsURL = "+NY&electionId=2000&officialOnly=true&returnAllAvailableData=true&fields=contests%2CdropOffLocations%2CearlyVoteSites%2Celection%2Ckind%2CmailOnly%2CnormalizedInput%2CotherElections%2CpollingLocations%2CprecinctId%2Csegments%2Cstate&key="
        
        
        self.stringCivicsURL = part1CivicsURL + modifiedAddress + part2CivicsURL + self.civicsAPIKey
        
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
        
        self.stringGeoURL = part1GeoURL + modifiedLocationName + part2GeoURL + self.geoAPIKey
        
        print(stringGeoURL)
    }
    
    func getCoordinate( address : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    
//    func openMapForPlace() {
//
//        let lat1 : NSString = self.venueLat
//        let lng1 : NSString = self.venueLng
//
//        let latitude:CLLocationDegrees =  lat1.doubleValue
//        let longitude:CLLocationDegrees =  lng1.doubleValue
//
//        let regionDistance:CLLocationDistance = 10000
//        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
//        ]
//        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "\(self.venueName)"
//        mapItem.openInMapsWithLaunchOptions(options)
//
//    }
//    Collapse
//
//
    

    
    


}
