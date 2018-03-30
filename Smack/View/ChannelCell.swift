//
//  ChannelCell.swift
//  Smack
//
//  Created by Patrik Kemeny on 30/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    // Outlets
    
    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
// you are selecting the channekls and we are changin the colors
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
            
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configureCell(channel : Channel) {
        let title = channel.channelTitle ?? "" // if you cant find channel title than empty string
        channelName.text = "# \(title)"
    }
    
}
