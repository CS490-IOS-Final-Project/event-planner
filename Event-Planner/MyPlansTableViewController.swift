//
//  MyPlansTableViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/11/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MyPlansTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var myEvents = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let curruser = Auth.auth().currentUser?.uid ?? ""
        let events = self.ref.child("Users/\(curruser)/Rsvp")
        var refHandle = events.observe(DataEventType.value, with: { (snapshot) in
            let eventsRsvpDict = snapshot.value as? [String : AnyObject] ?? [:]
            let eventsRsvpID = eventsRsvpDict.keys
            for eventID in eventsRsvpID {
                self.ref.child("Events").child(eventID).observeSingleEvent(of: .value, with: { (snapshot) in
                  // Get user value
                  let value = snapshot as! DataSnapshot
                    let event = Event(snapshot: value)!
                    self.myEvents.append(event)
                    self.tableView.reloadData()
                  // ...
                  }) { (error) in
                    print(error.localizedDescription)
                }
                
            }
            
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.myEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        let currEvent = self.myEvents[indexPath.row]
        
        cell.eventNameField.text = currEvent.eventName
        cell.eventLocationField.text = currEvent.location
        cell.eventHostField.text = "Host: \(currEvent.eventHostName ?? "Unknown")"
        cell.eventDateTimeField.text = currEvent.dateTime

        // Configure the cell...

        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
