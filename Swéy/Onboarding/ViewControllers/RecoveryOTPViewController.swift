//
//  RecoveryOTPViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 4/11/23.
//

import UIKit

class RecoveryOTPViewController: UIViewController, UITextFieldDelegate {
    
    required init?(coder: NSCoder) {
        fatalError("Not using storyboard initialization")
    }
    
    required init?(coder: NSCoder, otpToken: String, userEmail: String) {
        self.otptoken = otpToken
        self.userEmail = userEmail
        super.init(coder: coder)
    }
    
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var recoveryEmailLabel: UILabel!
    @IBOutlet weak var otpTextField: UITextField!
    
    private let otptoken: String
    private let userEmail: String
    
    private let otpPlaceholder = "------"
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
        
        self.recoveryEmailLabel.text = "Enter the 6-digit code sent to E-mail\n\(userEmail)"
        
        self.otpTextField.delegate = self
        self.otpTextField.text = self.otpPlaceholder
        self.otpTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let currentText = textField.text ?? ""
        let formattedText = formatOTP(currentText)
        textField.text = formattedText
        
        // Ensure the cursor stays after the last digit entered
        let cursorPosition = calculateCursorPosition(textField: textField)
        setCursorPosition(textField: textField, position: cursorPosition)
    }
    
    func formatOTP(_ text: String) -> String {
        // Remove non-digit characters (leaving only digits)
        let digitsOnly = text.replacingOccurrences(of: "-", with: "").filter { $0.isWholeNumber }
        var formattedText = otpPlaceholder
        
        // Replace dashes with the digits typed by the user
        for (index, digit) in digitsOnly.enumerated() {
            let start = formattedText.startIndex
            let position = formattedText.index(start, offsetBy: index)
            formattedText.replaceSubrange(position...position, with: String(digit))
        }
        
        return formattedText
    }
    
    // Ensure the cursor stays at the right position (after the last digit entered)
    func calculateCursorPosition(textField: UITextField) -> Int {
        let currentText = textField.text ?? ""
        let digitsOnly = currentText.replacingOccurrences(of: "-", with: "").filter { $0.isWholeNumber }
        return digitsOnly.count
    }
    
    func setCursorPosition(textField: UITextField, position: Int) {
        if let position = textField.position(from: textField.beginningOfDocument, offset: position) {
            textField.selectedTextRange = textField.textRange(from: position, to: position)
        }
    }
    
    // UITextFieldDelegate - Prevent non-digit characters and manage length
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let digitsOnly = currentText.replacingOccurrences(of: "-", with: "").filter { $0.isWholeNumber }
        let newLength = digitsOnly.count + string.count - range.length
        
        // Only allow up to 6 characters (since "------" represents 6 digits)
        if newLength > 6 {
            return false
        }
        
        // Only allow digit input
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
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
