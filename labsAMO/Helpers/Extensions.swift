//
//  Extensions.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit



@IBDesignable extension UIButton {
    
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
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UIView {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    func setupButton() {
        let button = UIBarButtonItem(image: UIImage.init(systemName: "square.stack.3d.up"), style: .plain, target: self, action: #selector(show(sender:)))
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func show(sender: UIBarButtonItem) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc : LabChooserViewController = mainStoryboard.instantiateViewController(withIdentifier: LabChooserViewController.identifier) as? LabChooserViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    
}


extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}


extension Formatter {
    static let scientific: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        
        formatter.positiveFormat = "0.###E+0"
        formatter.exponentSymbol = "*10^"
        
        return formatter
    }()
}

extension Numeric {
    var scientificFormatted: NSMutableAttributedString {
        let stringFromFormatter = Formatter.scientific.string(for: self) ?? ""
        
        /// ["4.267*10", "-1"] example of  `splitedString`
        let splitedString = stringFromFormatter.split(separator: "^")

        let result = NSMutableAttributedString()

        guard let font: UIFont = UIFont(name: "Helvetica", size:18) else { return NSMutableAttributedString() }
        guard let fontUpper: UIFont = UIFont(name: "Helvetica", size:12) else { return NSMutableAttributedString() }
        
        if stringFromFormatter == "NaN" || stringFromFormatter == "+∞" {
            return NSMutableAttributedString(string: String(splitedString[0]), attributes: [.font: font])
        } else {
            let attributedPart1: NSMutableAttributedString = NSMutableAttributedString(string: String(splitedString[0]), attributes: [.font: font])
            let attributedPart2: NSMutableAttributedString = NSMutableAttributedString(string: String(splitedString[1]), attributes: [.font: fontUpper,.baselineOffset:10])

            result.append(attributedPart1)
            result.append(attributedPart2)

            return result
        }
    }
}

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}


// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}


extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}

extension UITextField {
    func setText(_ text: String) {

        let label = UILabel(frame: CGRect(x: 6, y: 3, width: 20, height: 25))
        label.text = text
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(label)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}
