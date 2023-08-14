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
    
    private var originalViewPosition = CGPoint(x: 0.0, y: 0.0)
    
    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .light)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.2)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            dimmedView.backgroundColor = .black.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blurredView.frame = mainBackgroundBlur.bounds
        mainBackgroundBlur.addSubview(blurredView)
        
        let nib = UINib(nibName: String(describing: ChatListTableViewCell.self), bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: ChatListTableViewCell.self))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.mainBackgroundBlur.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackgroundTap)))
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:)))
        self.mainViewContainr.addGestureRecognizer(panGesture)
        
        self.originalViewPosition = self.mainViewContainr.frame.origin

        // Do any additional setup after loading the view.
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view?.window)
        let direction = sender.velocity(in: view?.window)
        var initialTouchPoint = CGPoint.zero

        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if touchPoint.y > initialTouchPoint.y && touchPoint.y > self.mainViewContainr.frame.origin.y {
                self.mainViewContainr.frame.origin.y = touchPoint.y - initialTouchPoint.y
            }
        case .ended, .cancelled:
            if touchPoint.y - initialTouchPoint.y > 600 {
                dismiss(animated: true, completion: nil)
            }
            else if direction.y > 0.0 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.mainViewContainr.frame = CGRect(x: self.originalViewPosition.x, y: self.originalViewPosition.y, width: self.mainViewContainr.frame.size.width, height: self.mainViewContainr.frame.size.height)
                })
            }
        default:
            dismiss(animated: true, completion: nil)
        }
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
