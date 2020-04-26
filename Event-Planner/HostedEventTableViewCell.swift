//
//  HostedEventTableViewCell.swift
//  Event-Planner
//
//  Created by Prahlad Anand on 4/25/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit

class HostedEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventDateTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
