//
//  TextChatTableViewCell.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/13/23.
//

import UIKit

class TextChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!

    private var edgeConstraint = NSLayoutConstraint()
    var backgroundLayer = CAGradientLayer()
    var isIncomingMessage = false
    var isAllRoundCorners = false
    var messageText = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0))
    }
    
    func setupCell() {
        if isIncomingMessage {
            self.setupOutgoingMessage()
        }
        else {
            self.setupIncomingMessage()
        }
        self.messageLabel.text = messageText
    }
    
    func setupOutgoingMessage() {
        
        backgroundLayer.colors = [
        UIColor(red: 0.306, green: 0.663, blue: 1, alpha: 1).cgColor,
        UIColor(red: 0.039, green: 0.498, blue: 1, alpha: 1).cgColor]
        backgroundLayer.startPoint = CGPoint(x: 0.75, y: 0.5)
        backgroundLayer.endPoint = CGPoint(x: 0.25, y: 0.5)
        backgroundLayer.locations = [0, 1]
        backgroundLayer.bounds = self.containerView.bounds.insetBy(dx: -0.5 * self.containerView.bounds.size.width, dy: -0.5 * self.containerView.bounds.size.height)
        backgroundLayer.position = self.containerView.center
        backgroundLayer.isHidden = false
        self.containerView.layer.insertSublayer(backgroundLayer, at: 0)
        self.messageLabel.textColor = UIColor.white
        self.edgeConstraint.isActive = false
        self.edgeConstraint = self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12.0)
        self.edgeConstraint.isActive = true
        self.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func setupIncomingMessage() {
        backgroundLayer.isHidden = true
        self.containerView.layer.backgroundColor = UIColor(named: "chatBubbleIncomingMessageBackgroundColor")?.resolvedColor(with: self.traitCollection).cgColor
        self.messageLabel.textColor =  UIColor(named: "chatTextColor")?.resolvedColor(with: self.traitCollection)
        self.edgeConstraint.isActive = false
        self.edgeConstraint = self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12.0)
        self.edgeConstraint.isActive = true
        let cornersMasks: CACornerMask = self.isAllRoundCorners ? [ .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner] : [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        self.containerView.layer.maskedCorners = cornersMasks
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.containerView.layer.backgroundColor = UIColor(named: "chatBubbleIncomingMessageBackgroundColor")?.resolvedColor(with: self.traitCollection).cgColor
        if !isIncomingMessage {
            self.messageLabel.textColor = UIColor(named: "chatTextColor")?.resolvedColor(with: self.traitCollection)
        }
    }
    
}
