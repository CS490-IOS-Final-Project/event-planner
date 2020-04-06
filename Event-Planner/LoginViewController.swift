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
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        // Do any additional setup after loading the view.
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
