//
//  PhoneNumberSignupViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 4/11/23.
//

import UIKit

class PhoneNumberSignInViewController: UIViewController {

    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.nextButton.clipsToBounds = false
        self.nextButton.layer.shadowColor = UIColor(red: 0, green: 0.4745098039215686, blue: 1, alpha: 0.65).cgColor
        self.nextButton.layer.shadowOpacity = 0.5
        self.nextButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.nextButton.layer.shadowRadius = 10
        self.nextButton.layer.masksToBounds = false
        
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
    
    @IBAction func onUserPhoneNumberTap(_ sender: Any) {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
    }
    @IBAction func onBackButtonTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onNextButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "StoreLanding", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StoreLandingNavigationController" ) as? UINavigationController
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
