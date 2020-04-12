//
//  CreateEventViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/11/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateEventViewController: UIViewController {

    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var dateAndTime: UIDatePicker!
    @IBOutlet weak var descriptionText: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    
    @IBAction func createEvent(_ sender: Any) {
        if (eventName.text == nil || eventName.text!.isEmpty) {
            print("empty event name")
            return
        }
        
        if (locationText.text == nil || locationText.text!.isEmpty) {
            print("empty location")
            return
        }
        
        if (descriptionText.text == nil || descriptionText.text!.isEmpty) {
            print("empty description")
            return
        }
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: dateAndTime.date)
        
        self.ref.child("Events").setValue(["Event Host": Auth.auth().currentUser?.uid,"Event Name": eventName.text!, "Location": locationText.text!, "Date and Time": strDate])
         
        
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
