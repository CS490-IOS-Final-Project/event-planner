//
//  LocationSearchViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/19/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase
import GooglePlaces

class LocationSearchViewController: UIViewController, GMSAutocompleteViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var locationSearchbar: UITextField!
    @IBOutlet weak var tabView: UITableView!
    var placeCoordinate: CLLocation!
    var events = [Event]()
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabView.tableFooterView = UIView()
        self.ref = Database.database().reference()
        
        updateTableView()
    }
    
    func updateTableView() {
        if (placeCoordinate == nil) {
            return
        }
        
        let allEvents = self.ref.child("Events")
        allEvents.queryOrdered(byChild: "EventName").observe(.value, with: {snapshot in
            self.events.removeAll(keepingCapacity: true)
            self.tabView.reloadData()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let event = Event(snapshot: snapshot) {
                    let eventLoc = event.locationId
                    
                    GMSPlacesClient.shared().lookUpPlaceID(eventLoc!) { (place, error) in
                        let destCoord = place?.coordinate
                        let dest = CLLocation(latitude: destCoord!.latitude, longitude: destCoord!.longitude)
                        
                        // Only add event if within 15000 meters ~ 10 miles
                        if (dest.distance(from: self.placeCoordinate) < 15000) {
                            self.events.append(event)
                            self.tabView.reloadData()
                        }
                    }
                }
            }
            
            
        })
    }

    
    
    @IBAction func searchPressed(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue))!
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        
        let currEvent = self.events[indexPath.row]
        
        cell.eventNameField.text = currEvent.eventName
        cell.eventLocationField.text = currEvent.location
        cell.eventHostField.text = "Host: \(currEvent.eventHostName ?? "Unknown")"
        cell.eventDateTimeField.text = currEvent.dateTime

        // Configure the cell...

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = self.tabView.indexPath(for: cell)!
        let event = self.events[indexPath.row]
        
        let detailsViewController = segue.destination as! EventDetailsViewController
        
        detailsViewController.event = event
        self.tabView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        locationSearchbar.text = place.formattedAddress
        self.placeCoordinate = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        GMSPlacesClient.shared().lookUpPlaceID(place.placeID!) { (place, error) in
            let destCoord = place?.coordinate
            self.placeCoordinate = CLLocation(latitude: destCoord!.latitude, longitude: destCoord!.longitude)
                        
            self.updateTableView()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    

}
