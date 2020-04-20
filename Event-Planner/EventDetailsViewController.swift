//
//  EventDetailsViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/19/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateTimeLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventHostnameLabel: UILabel!
    @IBOutlet weak var eventHostEmailLabel: UILabel!
    @IBOutlet weak var eventNumAttendeesLabel: UILabel!
    @IBOutlet weak var rsvpButton: UIButton!
    var currentUserId: String!
    var event: Event!
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ref = Database.database().reference()
        
        self.eventNameLabel.text = event.eventName
        self.eventDateTimeLabel.text = event.dateTime
        self.eventLocationLabel.text = event.location
        self.eventHostnameLabel.text = event.eventHostName
        self.eventHostEmailLabel.text = event.eventHostEmail
        self.eventNumAttendeesLabel.text = "\(event.attendeeCount ?? 0)"
        
        self.currentUserId = Auth.auth().currentUser?.uid
        
        
        self.ref.child("Users").child(self.currentUserId).child("Rsvp").child((event.ref?.key)!).observeSingleEvent(of: .value) { (snapshot) in
            if (!snapshot.exists()) {
                self.rsvpButton.setTitle("RSVP", for: .normal)
            } else {
                self.rsvpButton.setTitle("Cancel RSVP", for: .normal)
                self.rsvpButton.backgroundColor = UIColor.red
            }
        }
        
    }
    
    
    @IBAction func rsvpPressed(_ sender: Any) {
        
        self.ref.child("Users").child(self.currentUserId).child("Rsvp").child((event.ref?.key)!).observeSingleEvent(of: .value) { (snapshot) in
            if (!snapshot.exists()) {
                
                let eventId = self.event.ref!.key!
                
                // Add user RSVP to Event's info
                self.ref.child("Events").child(eventId).child("Rsvp").child(self.currentUserId).setValue("")
                
                // Add event RSVP to User's info
                self.ref.child("Users").child(self.currentUserId).child("Rsvp").child(eventId).setValue("")
                                
            } else {
                let eventId = self.event.ref!.key!
                
                // Add user RSVP to Event's info
                self.ref.child("Events").child(eventId).child("Rsvp").child(self.currentUserId).removeValue()
                
                // Add event RSVP to User's info
                self.ref.child("Users").child(self.currentUserId).child("Rsvp").child(eventId).removeValue()
            }
            
            self.navigationController?.popViewController(animated: true)
        }
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
