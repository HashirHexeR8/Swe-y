//
//  RecoveryOTPViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 4/11/23.
//

import UIKit

class RecoveryOTPViewController: UIViewController {
    
    @IBOutlet weak var verifyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.verifyButton.clipsToBounds = false
        self.verifyButton.layer.shadowColor = UIColor(red: 0, green: 0.4745098039215686, blue: 1, alpha: 0.65).cgColor
        self.verifyButton.layer.shadowOpacity = 0.5
        self.verifyButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.verifyButton.layer.shadowRadius = 10
        self.verifyButton.layer.masksToBounds = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 130)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func onBackButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onSendCodeButtonTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SignInViewController.self)) as? SignInViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
