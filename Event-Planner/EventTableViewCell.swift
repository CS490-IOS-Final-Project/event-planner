//
//  EventTableViewCell.swift
//  Event-Planner
//
//  Created by Prahlad Anand on 4/12/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventLocationField: UILabel!
    @IBOutlet weak var eventNameField: UILabel!
    @IBOutlet weak var eventHostField: UILabel!
    @IBOutlet weak var eventDateTimeField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
