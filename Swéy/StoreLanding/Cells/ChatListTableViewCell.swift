//
//  ChatListTableViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/11/23.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userMessage: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chatCheckBox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCellTap))
        self.contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func onCellTap(_ sender: Any) {
        chatCheckBox.isSelected = !chatCheckBox.isSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
}
