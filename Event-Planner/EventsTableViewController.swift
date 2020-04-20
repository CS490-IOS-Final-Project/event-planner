//
//  EventsTableViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/11/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Event {
    let ref: DatabaseReference?
    var dateTime: String?
    var eventHostName: String?
    var eventHostEmail: String?
    var eventName: String?
    var location: String?
    var attendeeCount: UInt?
    
    init (ref: DatabaseReference?, dateTime: String?, eventHostName: String?,  eventHostEmail: String?, eventName: String?, location: String?, attendeeCount: UInt?) {
        self.dateTime = dateTime
        self.eventHostName = eventHostName
        self.eventHostEmail = eventHostEmail
        self.eventName = eventName
        self.location = location
        self.ref = ref
        self.attendeeCount = attendeeCount
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let dateTime = value["DateTime"] as? String,
            let eventHostName = value["EventHostName"] as? String,
            let eventHostEmail = value["EventHostEmail"] as? String,
            let eventName = value["EventName"] as? String,
            let location = value["Location"] as? String
        else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.dateTime = dateTime
        self.eventHostName = eventHostName
        self.eventHostEmail = eventHostEmail
        self.eventName = eventName
        self.location = location
                
        self.ref?.child("Rsvp").observeSingleEvent(of: .value, with: { (snapshot) in
            self.attendeeCount = snapshot.childrenCount
        })
        
    }
    
}


class EventsTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var myEvents = [Event]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        ref = Database.database().reference()
        let events = self.ref.child("Events")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        events.queryOrdered(byChild: "EventName").observe(.value, with: {snapshot in
            var newEvents: [Event] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let newEvent = Event(snapshot: snapshot) {
                    print(newEvent)
                    newEvents.append(newEvent)
                }
            }
            
            print(newEvents)
            self.myEvents = newEvents
            self.tableView.reloadData()
        })
    }
    
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let currEvent = myEvents[indexPath.row]
        
        cell.eventNameField.text = currEvent.eventName
        cell.eventLocationField.text = currEvent.location
        cell.eventHostField.text = "Host: \(currEvent.eventHostName ?? "Unknown")"
        cell.eventDateTimeField.text = currEvent.dateTime

        // Configure the cell...

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let event = myEvents[indexPath.row]
        
        let detailsViewController = segue.destination as! EventDetailsViewController
        
        detailsViewController.event = event
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    

}
