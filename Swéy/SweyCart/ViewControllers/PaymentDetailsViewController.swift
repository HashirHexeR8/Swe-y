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
        firstCommButton.cornerRadius = 10.0
        secondCommButton.cornerRadius = 10.0
        thirdCommButton.cornerRadius = 10.0
        fourthCommButton.cornerRadius = 10.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        onFirstCommTap()
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
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.colors = [
        UIColor(red: 0.306, green: 0.663, blue: 1, alpha: 1).cgColor,
        UIColor(red: 0.039, green: 0.498, blue: 1, alpha: 1).cgColor]
        backgroundLayer.startPoint = CGPoint(x: 0.25, y: 1)
        backgroundLayer.endPoint = CGPoint(x: 0.75, y: 1)
        backgroundLayer.locations = [0, 1]
        backgroundLayer.bounds = button.bounds.insetBy(dx: -0.5 * button.bounds.size.width, dy: -0.5 * button.bounds.size.height)
        backgroundLayer.isHidden = false
        backgroundLayer.name = "GradientLayer"
        button.layer.insertSublayer(backgroundLayer, at: 0)
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    func makeButtonUnselected(button: UIButton) {
        if let layers = button.layer.sublayers {
            for (index, layer) in layers.enumerated() {
                if layer.name == "GradientLayer" {
                    button.layer.sublayers?[index].removeFromSuperlayer()
                    break
                }
            }
        }
        button.backgroundColor = UIColor(named: "paymentBackgroundColor")
        button.setTitleColor(UIColor(named: "paymentLabelsColor"), for: .normal)
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
