//
//  CreateEventViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/11/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase
import GooglePlaces

class CreateEventViewController: UIViewController, GMSAutocompleteViewControllerDelegate {
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var dateAndTime: UIDatePicker!
    @IBOutlet weak var descriptionText: UITextField!
    
    var ref: DatabaseReference!
    var placeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        locationText.isUserInteractionEnabled = false
    }
    
    
    @IBAction func createEvent(_ sender: Any) {
        var emptyMessage = "The following fields are empty:\n"
        var hasEmptyFields = false
        
        if (eventName.text == nil || eventName.text!.isEmpty) {
            emptyMessage += "Event Name\n"
            hasEmptyFields = true
        }
        
        if (locationText.text == nil || locationText.text!.isEmpty) {
            emptyMessage += "Event Location\n"
            hasEmptyFields = true
        }
        
        if (descriptionText.text == nil || descriptionText.text!.isEmpty) {
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
        
        let strDate = dateFormatter.string(from: dateAndTime.date)
        let userName = Auth.auth().currentUser?.displayName ?? ""
        let userEmail = Auth.auth().currentUser?.email ?? ""
        let userId = Auth.auth().currentUser?.uid ?? ""
        
        let newEvent = self.ref.child("Events").childByAutoId()
        
        newEvent.setValue(["EventHostName": userName, "EventHostEmail": userEmail,"EventName": eventName.text!, "Location": locationText.text!, "LocationID": placeId!, "DateTime": strDate, "EventDescription": descriptionText.text!])
        
        self.ref.child("Users").child(userId).child("Hosted").child(newEvent.key!).setValue("")
        
        
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
      locationText.text = place.formattedAddress
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
    
}
