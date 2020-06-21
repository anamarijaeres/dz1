//
//  LeaderTableViewCell.swift
//  QuizApp1
//
//  Created by five on 19/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import UIKit

class LeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
