//
//  PaymentDetailsViewController.swift
//  Swey
//
//  Created by Muhammad Hashir on 9/7/23.
//

import UIKit

class PaymentDetailsViewController: UIViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var firstCommButton: UIButton!
    @IBOutlet weak var secondCommButton: UIButton!
    @IBOutlet weak var thirdCommButton: UIButton!
    @IBOutlet weak var fourthCommButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onNoCommTap() {
        amountLabel.text = "$150"
        makeButtonSelected(button: firstCommButton)
        makeButtonUnselected(button: secondCommButton)
        makeButtonUnselected(button: thirdCommButton)
        makeButtonUnselected(button: fourthCommButton)
        
    }
    
    @IBAction func onFirstCommTap() {
        amountLabel.text = "$150 + $15 = $165"
        makeButtonUnselected(button: firstCommButton)
        makeButtonSelected(button: secondCommButton)
        makeButtonUnselected(button: thirdCommButton)
        makeButtonUnselected(button: fourthCommButton)
    }
    
    @IBAction func onSecondCommTap() {
        amountLabel.text = "$150 + $37.5 = $187.5"
        makeButtonUnselected(button: firstCommButton)
        makeButtonUnselected(button: secondCommButton)
        makeButtonSelected(button: thirdCommButton)
        makeButtonUnselected(button: fourthCommButton)
    }
    
    @IBAction func onThirdCommTap() {
        amountLabel.text = "$150 + $75 = $225"
        makeButtonUnselected(button: firstCommButton)
        makeButtonUnselected(button: secondCommButton)
        makeButtonUnselected(button: thirdCommButton)
        makeButtonSelected(button: fourthCommButton)
    }
    
    @IBAction func onNextButtonTap() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: TransferConfirmationViewController.self)) as? TransferConfirmationViewController
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func onBackButtonTap() {
        dismiss(animated: true)
    }
    
    func makeButtonSelected(button: UIButton) {
        button.backgroundColor = UIColor(hexString: "#0079FF", alpha: 0.73)
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    func makeButtonUnselected(button: UIButton) {
        button.backgroundColor = UIColor(hexString: "#F2F2F2")
        button.setTitleColor(UIColor.black, for: .normal)
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
