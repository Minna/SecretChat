//
//  MessageTableCell.swift
//  SecretChat
//
//  Created by Minna on 01/05/21.
//

import UIKit

class MessageTableCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rigtImage: UIImageView!
    @IBOutlet weak var messageBulb: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBulb.layer.cornerRadius = messageBulb.frame.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
