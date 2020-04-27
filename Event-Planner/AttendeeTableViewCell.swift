//
//  AttendeeTableViewCell.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/26/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit

class AttendeeTableViewCell: UITableViewCell {

    @IBOutlet weak var attendeeNameLabel: UILabel!
    @IBOutlet weak var attendeeEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
