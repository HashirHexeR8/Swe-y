//
//  ChatViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 6/11/23.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatBackgroundBlur: UIView!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var chatViewContainer: UIView!
    @IBOutlet weak var chatBackgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainViewContainr: UIView!
    @IBOutlet weak var mainBackgroundBlur: UIView!
    @IBOutlet weak var linkCopiedView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        
//        // Create a visual effect view with the blur effect
//        let chatBlurView = UIVisualEffectView(effect: blurEffect)
//
//        // Set the frame to cover the entire view
//        chatBlurView.frame = chatBackgroundBlur.bounds
//
//        // Add the visual effect view as a subview
//        chatBackgroundBlur.addSubview(chatBlurView)
        
        // Create a visual effect view with the blur effect
        let mainBackgroundBlurView = UIVisualEffectView(effect: blurEffect)
        
        // Set the frame to cover the entire view
        mainBackgroundBlurView.frame = mainBackgroundBlur.bounds
        
        // Add the visual effect view as a subview
        mainBackgroundBlur.addSubview(mainBackgroundBlurView)
        
        let nib = UINib(nibName: String(describing: ChatListTableViewCell.self), bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: ChatListTableViewCell.self))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.mainBackgroundBlur.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackgroundTap)))
        
        let dragDownGesture = UISwipeGestureRecognizer(target: self, action:#selector(didSwipeDown))
        dragDownGesture.direction = .down
        dragDownGesture.cancelsTouchesInView = true
        self.view.addGestureRecognizer(dragDownGesture)
        
    }
    
    @objc func didSwipeDown(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func onBackgroundTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onLinkButtonTap(_ sender: Any) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.linkCopiedView.isHidden = false
            _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        })
    }
    
    @objc func update() {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.linkCopiedView.isHidden = true
        })
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatListTableViewCell.self)) as! ChatListTableViewCell
        switch indexPath.row {
        case 0:
            cell.userProfile.image = UIImage(named: "chatUser1")
            cell.userName.text = "Marcia"
            cell.userMessage.text = "Really? That’s great. We will do watch….."
            cell.chatCheckBox.isSelected = true
        case 1:
            cell.userProfile.image = UIImage(named: "chatUser2")
            cell.userName.text = "Faith"
            cell.userMessage.text = "Really? That’s great. We will do watch….."
        default:
            cell.userProfile.image = UIImage(named: "chatUser3")
            cell.userName.text = "Shirley"
            cell.userMessage.text = "Really? That’s great. We will do watch….."
            cell.chatCheckBox.isSelected = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
