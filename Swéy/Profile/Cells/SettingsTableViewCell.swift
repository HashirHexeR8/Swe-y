//
//  SettingsTableViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 9/10/23.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet private var themeSwitch: UISwitch!
    @IBOutlet private var nextIcon: UIImageView!
    @IBOutlet private var settingsNameLabel: UILabel!
    @IBOutlet private var settingsIcon: UIImageView!
    @IBOutlet private var iconHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var iconWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var iconLeadingConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }
    
    func setupCell(labelText: String, iconImage: UIImage?, isModeSwitch: Bool, isProfileImage: Bool) {
        self.settingsNameLabel.text = labelText
        self.settingsIcon.image = iconImage
        self.themeSwitch.isHidden = !isModeSwitch
        self.nextIcon.isHidden = isModeSwitch
        if isProfileImage {
            iconHeightConstraint.constant = 38.0
            iconWidthConstraint.constant = 38.0
            iconLeadingConstraint.constant = 12.0
        }
        else {
            iconHeightConstraint.constant = 20.0
            iconWidthConstraint.constant = 20.0
            iconLeadingConstraint.constant = 20.0
        }
    }
    
}
