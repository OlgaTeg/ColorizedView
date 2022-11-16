//
//  ViewController.swift
//  ColorizedView
//
//  Created by Olga Tegza on 28.10.2022.
//

import UIKit

class ChangeViewController: UIViewController, UITextFieldDelegate {
    
    var receivedColor: UIColor!
    var delegate: ChangeViewControllerDelegate!
    
    //MARK: - IBOutlets
    @IBOutlet var colorizedView: UIView!
    
    @IBOutlet var rgbSliders: [UISlider]!
    
    @IBOutlet var colorLabels: [UILabel]!
    
    @IBOutlet var colorTextFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for textField in colorTextFields {
            textField.delegate = self
        }
        
        setColorValues(accordingTo: setRGBValues(from: receivedColor))
        setColor()
    }
    
    //MARK: - IBActions
    @IBAction func doneButtonTapped() {
        if let someColor = colorizedView.backgroundColor {
            delegate.setBackgroundColor(by: someColor)
        }
        dismiss(animated: true)
    }
    
    
    @IBAction func rgbSliderAction(_ sender: UISlider) {
        setColor()
        setSlidersValues(for: sender.tag, from: sender)
    }
    
    private func setColor() {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(rgbSliders[0].value),
            green: CGFloat(rgbSliders[1].value),
            blue: CGFloat(rgbSliders[2].value),
            alpha: 1
        )
    }
}

//MARK: - Extension set values
extension ChangeViewController {
    
    private func setColorValues(accordingTo colors: [CGFloat]) {
        for (color, slider) in zip(colors, rgbSliders) {
            slider.setValue(Float(color), animated: true)
        }
        
        for (label, slider) in zip(colorLabels, rgbSliders) {
            label.text = string(from: slider)
        }
        
        for (textField, slider) in zip(colorTextFields, rgbSliders) {
            textField.text = string(from: slider)
        }
    }
    
    private func setSlidersValues(for tag: Int, from slider: UISlider ) {
        colorLabels[tag].text = string(from: slider)
        colorTextFields[tag].text = string(from: slider)
    }
    
    private func setTextFieldValue(for tag: Int, from textField: UITextField) {
        colorLabels[tag].text = textField.text
        if let text = textField.text {
            if let text = Float(text) {
                rgbSliders[tag].value = text
            }
        }
    }
    
    private func setRGBValues(from color: UIColor) -> [CGFloat] {
        let redColor = CIColor(color: color).red
        let greenColor = CIColor(color: color).green
        let blueColor = CIColor(color: color).blue
        
        return [redColor, greenColor, blueColor]
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

//MARK: - Extension change values in textFields

extension ChangeViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard getCorrectResult(for: isCorrect(textField)) else {
            textField.text = nil
            return }
        setTextFieldValue(for: textField.tag, from: textField)
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyBoardToolBar = UIToolbar()
        keyBoardToolBar.sizeToFit()
        textField.inputAccessoryView = keyBoardToolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyBoardToolBar.items = [flexBarButton, doneButton]
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        convertСommaToDot(for: string, in: textField)
    }
    
    private func convertСommaToDot(for string: String, in textfield: UITextField) -> Bool {
        if string == "," {
            guard let text = textfield.text else { return true }
            textfield.text = text + "."
            return false
        }
        return true
    }
}

//MARK: - Extension set alert controller
extension ChangeViewController {

    private func getCorrectResult(for value: Bool) -> Bool {
        guard value else {
            showAlert(
                title: "Error",
                message: "Enter the number from 0.00 to 1.00"
            )
            return false
        }
        return true
    }

    private func isCorrect(_ value: UITextField) -> Bool {
        guard let correctString = value.text else { return false }
        guard let correctNumber = Double(correctString) else { return false }
        guard correctNumber.description.count <= 4 else { return false }
        guard correctNumber >= 0 && correctNumber <= 1.0 else { return false }
        return true
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
