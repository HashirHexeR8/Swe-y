//
//  Extensions.swift
//  Swéy
//
//  Created by Muhammad Hashir on 3/29/23.
//

import UIKit
@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension UIImage{

    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage
    }
}

extension UISegmentedControl{
    func removeBorder() {
        weak var color: CGColor?
        
        color = UIColor.clear.cgColor
        
        let backgroundImage = UIImage.getColoredRectImageWith(color: color!, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)

        let deviderImage = UIImage.getColoredRectImageWith(color: color!, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 67/255, green: 129/255, blue: 244/255, alpha: 1.0)], for: .selected)
    }
    
    func changeBackgroundForAppearanceSwitch() {
        removeBorder()
    }
    
    func addUnderlineForSelectedSegment() {
        removeBorder()
        
        var underlineWidth: CGFloat = (self.bounds.size.width / CGFloat(self.numberOfSegments)) - (self.bounds.size.width/13)
        
        let underlineHeight: CGFloat = 2
        var underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth)) + 9000/self.bounds.width
        
        if self.widthForSegment(at: self.selectedSegmentIndex) > 0.0 {
            underlineWidth = self.widthForSegment(at: self.selectedSegmentIndex) - 10.0
            underlineXPosition = 10.0
        }
        

        let underLineYPosition = self.bounds.maxY - 3.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor(hexString: "#0079FF")
        underline.layer.cornerRadius = 2
        underline.tag = 1
        self.addSubview(underline)
    }

    func changeUnderlinePosition() {
        
        guard let underline = self.viewWithTag(1) else {return}
        
        // calculates proper offset for different screen sizes (is approximate)
        var divisor: CGFloat = 45
        if (self.bounds.width > 420) {
            divisor = 25
        } else if (self.bounds.width > 400) {
            divisor = 28
        } else if (self.bounds.width > 385) {
            divisor = 39
        }
        
        var underlineWidth: CGFloat = (self.bounds.size.width / CGFloat(self.numberOfSegments)) - (self.bounds.size.width/13)
        if self.widthForSegment(at: self.selectedSegmentIndex) > 0.0 {
            underlineWidth = self.widthForSegment(at: self.selectedSegmentIndex) - 10.0
            underline.frame.size.width = underlineWidth
        }
        
        var underlineFinalXPosition = ((self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)) + CGFloat(self.bounds.width)/divisor
        
        if self.selectedSegmentIndex - 1 >= 0 {
            var underLinePosition = self.widthForSegment(at: self.selectedSegmentIndex - 1)
            if underLinePosition > 0.0 {
                underlineFinalXPosition = underLinePosition + 8.0
            }
        }
        
        
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
    
    func changeUnderlinePositionForStartup() {
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = ((self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)) + 10
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UISwitch {
    func changeSwitchImage() {
        self.onImage = UIImage(named: "toggleSwitchOn")
        self.offImage = UIImage(named: "toggleSwitchOff")
    }
}

extension UITextField{

        @IBInspectable var doneAccessory: Bool{
            get{
                return self.doneAccessory
            }
            set (hasDone) {
                if hasDone{
                    addDoneButtonOnKeyboard()
                }
            }
        }

        func addDoneButtonOnKeyboard()
        {
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            self.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction() {
            self.resignFirstResponder()
        }

}

extension UITextView {

        @IBInspectable var doneAccessory: Bool{
            get{
                return self.doneAccessory
            }
            set (hasDone) {
                if hasDone{
                    addDoneButtonOnKeyboard()
                }
            }
        }

        func addDoneButtonOnKeyboard()
        {
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            self.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction() {
            self.resignFirstResponder()
        }

}

@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var inset: CGFloat = 0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
