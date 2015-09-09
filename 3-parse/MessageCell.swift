//
//  MessageCell.swift
//  3-parse
//
//  Created by Victor Zhang on 9/9/15.
//  Copyright (c) 2015 Victor Zhang. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userLabel.text = "Anonymous user"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
