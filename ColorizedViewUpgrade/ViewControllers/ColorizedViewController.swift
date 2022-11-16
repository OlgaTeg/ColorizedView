//
//  ColorizedViewController.swift
//  ColorizedViewUpgrade
//
//  Created by Olga Tegza on 15.11.2022.
//

import UIKit

protocol ChangeViewControllerDelegate {
    func setBackgroundColor(by color: UIColor)
}

class ColorizedViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let changeVC = segue.destination as? ChangeViewController {
            changeVC.receivedColor = view.backgroundColor
            changeVC.delegate = self
        }
    }
}
 
extension ColorizedViewController: ChangeViewControllerDelegate {
    func setBackgroundColor(by color: UIColor) {
        view.backgroundColor = color
    }
}

