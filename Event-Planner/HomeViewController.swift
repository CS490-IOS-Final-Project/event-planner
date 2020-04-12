//
//  HomeViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/11/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class HomeViewController: UIViewController {
    @IBOutlet weak var createEventMenu: UIView!
    @IBOutlet weak var viewEventsMenu: UIView!
    @IBOutlet weak var viewLocationMenu: UIView!
    @IBOutlet weak var viewPlansMenu: UIView!
    @IBOutlet weak var viewOrganizerMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Get name through Auth.auth().currentUser and display Welcome message through first name
        let name = Auth.auth().currentUser?.displayName ?? ""
        let firstName = name.split(separator: " ")[0]
        let greeting = "Welcome \(firstName)!"
        self.title = greeting
        
        // Add grey border to end of each menu option
        for view in [createEventMenu, viewEventsMenu, viewLocationMenu, viewPlansMenu, viewOrganizerMenu] {
            addBottomBorder(view: view)
        }
        
        // Customization of bar button back text
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: nil, action: nil)
        
    }
    
    func addBottomBorder(view: UIView!) {
        let border = CALayer()
        border.backgroundColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.size.width, height: 1)
        view.layer.addSublayer(border)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onLogout(_ sender: Any) {
        // Perform google logout, after confirmation of user
        let dialogMessage = UIAlertController(title: nil, message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "Logout", style: .destructive) { (UIAlertAction) in
            do {
                // Sign out Auth.auth() instance as well as GIDSignIn instance
                try Auth.auth().signOut()
                GIDSignIn.sharedInstance()?.signOut()
            } catch {
                print("Error Signing out")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
}
