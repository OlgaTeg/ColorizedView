//
//  ViewController.swift
//  ColorizedView
//
//  Created by Olga Tegza on 28.10.2022.
//

import UIKit

class ViewController: UIViewController {

//MARK: - IBOutlets
    
    @IBOutlet var colorizedView: UIView!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliders()
        setupInitialColor()
    }

//MARK: - IBActions
    
    @IBAction func redSliderChange(_ sender: UISlider) {
        redLabel.text = String(format: "%.2f", redSlider.value)
        changeColor()
    }
    
    @IBAction func greenSliderChange(_ sender: UISlider) {
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        changeColor()
    }
    
    @IBAction func blueSliderChange(_ sender: UISlider) {
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        changeColor()
    }
    
    
//MARK: - Private fuctions
    
    private func setupSliders() {
        redSlider.value = 0.00
        redSlider.minimumValue = 0.00
        redSlider.maximumValue = 1.00
        redSlider.minimumTrackTintColor = .systemRed
        
        greenSlider.value = 0.00
        greenSlider.minimumValue = 0.00
        greenSlider.maximumValue = 1.00
        greenSlider.minimumTrackTintColor = .systemGreen
        
        blueSlider.value = 0.00
        blueSlider.minimumValue = 0.00
        blueSlider.maximumValue = 1.00
        blueSlider.minimumTrackTintColor = .systemBlue
    }
    
    private func setupInitialColor() {
        colorizedView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    }
    
    private func generateColor() {
        colorizedView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    private func changeColor() {
        if greenSlider.value > 0 || redSlider.value > 0 || blueSlider.value > 0 {
            generateColor()
        } else {
            setupInitialColor()
        }
    }
}

