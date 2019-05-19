//
//  ViewController.swift
//  SimpleRotatingPoligons
//
//  Created by Yurii Boiko on 5/19/19.
//  Copyright © 2019 yurssoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var shapeButton: UIButton!
    
    @IBAction func shapeButtonPressed(_ sender: UIButton) {
        increaseSideNumber()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        increaseSideNumber()
    }
    
    private var sides = 2
    
    private func increaseSideNumber() {
        let name = "LAYER"
        view.layer.sublayers?.first(where: { $0.name == name })?.removeFromSuperlayer()
        sides += 1
        let ss = SimpleRegularPolygon()
        do {
            try ss.setNumber(of: sides)
            ss.radius = 50
            let layer = CAShapeLayer()
            layer.name = name
            layer.path = ss.calculatePolygon(center: view.center)
            layer.lineWidth = 2
            layer.fillColor = UIColor.white.cgColor
            layer.strokeColor = UIColor.red.cgColor
            view.layer.addSublayer(layer)
        } catch {
            print(error)
        }
    }
}

