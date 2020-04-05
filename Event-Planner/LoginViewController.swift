//
//  LoginViewController.swift
//  Event-Planner
//
//  Created by Prahlad Anand on 4/4/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewCell {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBOutlet weak var onRegister: UIButton!
    @IBAction func onSignIn(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
