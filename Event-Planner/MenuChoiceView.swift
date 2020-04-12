//
//  MenuChoiceView.swift
//  Event-Planner
//
//  Created by Aditya Subramaniam on 4/11/20.
//  Copyright © 2020 cs490group. All rights reserved.
//

import UIKit

class MenuChoiceView: UIView {

    var touchdown: Bool = false
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchdown = true
        self.backgroundColor = UIColor.separator
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.touchdown) {
            self.backgroundColor = UIColor.systemTeal
            self.touchdown = false
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backgroundColor = UIColor.systemTeal
        self.touchdown = false
    }

}
