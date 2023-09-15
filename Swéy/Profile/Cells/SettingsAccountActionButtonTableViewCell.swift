//
//  SettingsAccountActionButtonTableViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 9/14/23.
//

import UIKit

class SettingsAccountActionButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actionButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(buttonText: String, isLogoutButton: Bool) {
        actionButton.setTitle(buttonText, for: .normal)
        actionButton.setTitle(buttonText, for: .focused)
        actionButton.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 13.0)
        if isLogoutButton {
            actionButton.setTitleColor(UIColor(hexString: "#E50000"), for: [])
        }

    }
    
}
