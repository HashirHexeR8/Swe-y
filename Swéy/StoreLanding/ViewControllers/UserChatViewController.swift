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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.usersCollectionView.delegate = self
        self.usersCollectionView.dataSource = self
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        
        let userProfileCellNib = UINib(nibName: String(describing: QuickPayUserCollectionViewCell.self), bundle: nil)
        self.usersCollectionView.register(userProfileCellNib, forCellWithReuseIdentifier: String(describing: QuickPayUserCollectionViewCell.self))

        let chatMessageCellNib = UINib(nibName: String(describing: ChatMessageTableViewCell.self), bundle: nil)
        self.chatTableView.register(chatMessageCellNib, forCellReuseIdentifier: String(describing: ChatMessageTableViewCell.self))
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
