//
//  LoginViewController.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/5/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set sharedInstance's view controller to LoginViewController
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Restore session if user left app without signing out
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        // Do any additional setup after loading the view.
        
        // Call's sign function in AppDelegate to login through google
        GIDSignIn.sharedInstance().signIn()
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
