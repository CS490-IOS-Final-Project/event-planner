//
//  EditEventViewController.swift
//  Event-Planner
//
//  Created by Sreekara Yachamaneni on 4/18/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase
import GooglePlaces

class EditEventViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    var event: Event!
    var ref: DatabaseReference!
    var placeId: String?
    
    var eventId: String?
    
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDateTime: UIDatePicker!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var eventAttendees: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        eventLocation.isUserInteractionEnabled = false
        
        eventLocation.text = event.location as String?
        eventName.text = event.eventName as String?
        eventDescription.text = event.description as String?
        eventAttendees.text = "\(event.attendeeCount ?? 0)"
        
        self.placeId = event.locationId
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let attendeeesTableViewController = segue.destination as! AttendeesTableViewController
        
        attendeeesTableViewController.eventId = event.eventId
    }
    
    @IBAction func saveEvent(_ sender: UIButton!) {
        var emptyMessage = "The following fields are empty:\n"
        var hasEmptyFields = false
        
        if (eventName.text == nil || eventName.text!.isEmpty) {
            emptyMessage += "Event Name\n"
            hasEmptyFields = true
        }
        
        if (eventLocation.text == nil || eventLocation.text!.isEmpty) {
            emptyMessage += "Event Location\n"
            hasEmptyFields = true
        }
        
        if (eventDescription.text == nil || eventDescription.text!.isEmpty) {
            emptyMessage += "Event Description\n"
            hasEmptyFields = true
        }
        
        if (hasEmptyFields) {
            let dialogMessage = UIAlertController(title: "Empty Fields", message: emptyMessage, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: eventDateTime.date)
                
        let currEvent = self.ref.child("Events").child((self.event.ref?.key)!)
        
        let update = [
            "EventName": eventName.text!,
            "Location": eventLocation.text!,
            "DateTime": strDate,
            "LocationID": placeId!,
            "EventDescription": eventDescription.text ?? ""
            ] as [String : Any]
        
        currEvent.updateChildValues(update)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
          UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue))!
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
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
      eventLocation.text = place.formattedAddress
      self.placeId = place.placeID
      dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
      // TODO: handle the error.
      print("Error: ", error.localizedDescription)
    }

    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
      dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
