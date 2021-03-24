//
//  GradientView.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import UIKit

@IBDesignable

class GradientView: UIView {

    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var SecondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor,
                        SecondColor.cgColor]
    }

}
