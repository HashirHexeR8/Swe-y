//
//  DOBPickerViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 4/11/23.
//

import UIKit

class DOBPickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelLabel: UILabel!
    
    var onDatePicked: ((Date) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        // 2
        let blurEffect = UIBlurEffect(style: .extraLight)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(blurView, at: 0)
        
        datePicker.maximumDate = Date()
        
        let range = ("Cancel" as NSString).range(of: "Cancel")

        let mutableAttributedString = NSMutableAttributedString.init(string: "Cancel")
        
        let attributes:[NSAttributedString.Key : Any] = [.font : UIFont(name: "Poppins-Bold", size: 12.0)]
        mutableAttributedString.addAttributes(attributes, range: range)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "onboardingLabelButtonColor"), range: range)
        cancelLabel.attributedText = mutableAttributedString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapCancelBtn(_:)))
        cancelLabel.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    
    @objc func onTapCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapSelectBtn(_ sender: Any) {
        onDatePicked?(datePicker.date)
        dismiss(animated: true, completion: nil)
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
