//
//  AttendeesTableViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/26/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase

class AttendeesTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var eventId: String!
    var attendees = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.ref = Database.database().reference()
        self.attendees.removeAll()
        
        self.ref.child("Events").child(self.eventId).child("Rsvp").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                self.attendees.append(snap.value as! String)
            }
            
            self.tableView.reloadData()
            
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.attendees.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeeTableViewCell", for: indexPath) as! AttendeeTableViewCell
        
        let currAttendee = self.attendees[indexPath.row]
        let currAttendeeParts = currAttendee.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)
        
        // Configure the cell...
        cell.attendeeEmailLabel.text = String(currAttendeeParts[0])
        cell.attendeeNameLabel.text = String(currAttendeeParts[1])
        cell.selectionStyle = .none

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
