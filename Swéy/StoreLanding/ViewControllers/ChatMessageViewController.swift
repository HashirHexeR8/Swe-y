//
//  ChatMessageViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 8/13/23.
//

import UIKit

class ChatMessageViewController: UIViewController {
    
    @IBOutlet weak var chatsTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.chatsTableView.delegate = self
        self.chatsTableView.dataSource = self
        
        let textMessageNib = UINib(nibName: String(describing: TextChatTableViewCell.self), bundle: nil)
        self.chatsTableView.register(textMessageNib, forCellReuseIdentifier: String(describing: TextChatTableViewCell.self))
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        self.dismiss(animated: true)
    }

}

extension ChatMessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextChatTableViewCell.self), for: indexPath) as! TextChatTableViewCell
        if indexPath.row == 0 {
            cell.isIncomingMessage = false
            cell.messageText = "Hellow Bro! How are you?"
        }
        else if indexPath.row == 1 {
            cell.isIncomingMessage = true
            cell.messageText = "Hi Mohammad! Im fine and you?"
        }
        else if indexPath.row == 2 {
            cell.isIncomingMessage = false
            cell.messageText = "Not bad, i just finished Swimming and take the dinner with my parent."
        }
        else {
            cell.isIncomingMessage = false
            cell.messageText = "Not bad, i just finished Swimming and take the dinner with my parent. Let's try to make this even more bigger so we can see if it actually works for a very long text but not sure if it will."
        }
        cell.setupCell()
        return cell
    }

}
