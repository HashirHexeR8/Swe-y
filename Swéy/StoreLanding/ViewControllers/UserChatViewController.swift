//
//  UserChatViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/13/23.
//

import UIKit

class UserChatViewController: UIViewController {
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.usersCollectionView.delegate = self
        self.usersCollectionView.dataSource = self
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        
        let chatSize = ("All Chats" as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "DMSans-Bold", size: 12.0)])
        let shoppingChatSize = ("Friends Shopping Carts" as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont(name: "DMSans-Bold", size: 12.0)])
        let fontAttributes = [NSAttributedString.Key.font: self.chatSegmentedControl.titleTextAttributes(for: .selected)]
        self.chatSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 12.0)], for: .normal)
        self.chatSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DMSans-Bold", size: 12.0)], for: .selected)
        self.chatSegmentedControl.setWidth(chatSize.width + 25.0, forSegmentAt: 0)
        self.chatSegmentedControl.setWidth(shoppingChatSize.width + 30.0, forSegmentAt: 1)
        self.chatSegmentedControl.addUnderlineForSelectedSegment()
        
        let userProfileCellNib = UINib(nibName: String(describing: QuickPayUserCollectionViewCell.self), bundle: nil)
        self.usersCollectionView.register(userProfileCellNib, forCellWithReuseIdentifier: String(describing: QuickPayUserCollectionViewCell.self))

        let chatMessageCellNib = UINib(nibName: String(describing: ChatMessageTableViewCell.self), bundle: nil)
        self.chatTableView.register(chatMessageCellNib, forCellReuseIdentifier: String(describing: ChatMessageTableViewCell.self))
    }
    
    @IBAction func onSegmentValueChanged() {
        self.chatSegmentedControl.changeUnderlinePosition()
    }
    
    @IBAction func onTapAdd(_ sender: Any) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: CreateChatOptionsViewController.self)) as? CreateChatOptionsViewController
        vc?.modalPresentationStyle = .overCurrentContext
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.chatSegmentedControl.changeBackgroundForAppearanceSwitch()
    }

}

extension UserChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: QuickPayUserCollectionViewCell.self), for: indexPath) as! QuickPayUserCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 120)
    }
}

extension UserChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatMessageTableViewCell.self), for: indexPath) as! ChatMessageTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ChatMessageViewController.self)) as? ChatMessageViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
}
