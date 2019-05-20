//
//  RotatingCell.swift
//  SimpleRotatingPolygons
//
//  Created by Yurii Boiko on 5/19/19.
//  Copyright © 2019 yurssoft. All rights reserved.
//

import UIKit

protocol RotatingCellDelegate: class {
    func didTapRotateButton(layer: CALayer, indexPath: IndexPath)
}

class RotatingCell: UICollectionViewCell {
    static let layerName = "LAYERNAME"
    weak var delegate: RotatingCellDelegate?
    var cellIndexPath: IndexPath!
    @IBOutlet weak var rotatingButton: UIButton!
    
    func setupPolygon() {
        if let layerToRotate = layerToRotate() {
            layerToRotate.removeFromSuperlayer()
        }
        let simplePolygon = SimpleRegularPolygon()
        do {
            try simplePolygon.setNumber(of: Int.random(in: 3...11))
            simplePolygon.radius = Int(rotatingButton.frame.height/4)
            let shapeLayer = CAShapeLayer()
            shapeLayer.name = RotatingCell.layerName
            shapeLayer.frame = rotatingButton.bounds
            shapeLayer.bounds = rotatingButton.frame
            shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            shapeLayer.path = simplePolygon.calculatePolygon(center: rotatingButton.center)
            shapeLayer.lineWidth = 2
            let fillColor = UIColor(red:   randomNumber,
                                    green: randomNumber,
                                    blue:  randomNumber,
                                    alpha: 1.0)
            let strokeColor = UIColor(red:   randomNumber,
                                      green: randomNumber,
                                      blue:  randomNumber,
                                      alpha: 1.0)
            shapeLayer.fillColor = fillColor.cgColor
            shapeLayer.strokeColor = strokeColor.cgColor
            rotatingButton.layer.addSublayer(shapeLayer)
        } catch {
            print(error)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPolygon()
    }
    
    var randomNumber: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func layerToRotate() -> CALayer? {
        if let layerToRotate = rotatingButton.layer.sublayers?.first(where: {
            if let name = $0.name, name == RotatingCell.layerName {
                return true
            }
            return false
        }) {
            return layerToRotate
        }
        return nil
    }
    
    @IBAction func rotatingButtonPressed(_ sender: Any) {
        if let layerToRotate = layerToRotate() {
            delegate?.didTapRotateButton(layer: layerToRotate, indexPath: cellIndexPath)
        }
    }
}
