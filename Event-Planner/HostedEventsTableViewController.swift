//
//  HostedEventsTableViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/11/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase


class HostedEventsTableViewController: UITableViewController {
    var ref: DatabaseReference!
    var myEvents = [Event]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        ref = Database.database().reference()
        let username = Auth.auth().currentUser?.displayName ?? ""
        let events = self.ref.child("Events")
        
        events.queryOrdered(byChild: "EventHostName").queryEqual(toValue: username).observe(.value, with: {snapshot in
            
            var newEvents: [Event] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let newEvent = Event(snapshot:snapshot){
                    newEvents.append(newEvent)
                }
            }
            
            let dateFormatter = DateFormatter()

            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            
            self.myEvents = newEvents.sorted(by: { (e1, e2) -> Bool in
                return dateFormatter.date(from: e1.dateTime!)?.compare(dateFormatter.date(from: e2.dateTime!)!) == ComparisonResult.orderedAscending
            })
            self.tableView.reloadData()
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "HostedEventTableViewCell", for: indexPath) as! HostedEventTableViewCell
        
        let currEvent = myEvents[indexPath.row]
        
        cell.eventName.text = currEvent.eventName as String?
        cell.eventLocation.text = currEvent.location
        cell.eventDateTime.text = currEvent.dateTime
        cell.eventDescription.text = currEvent.description
        
        // Configure the cell...

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let event = myEvents[indexPath.row]

        let editViewController = segue.destination as! EditEventViewController

        editViewController.event = event
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
