//
//  RotatingCell.swift
//  SimpleRotatingPoligons
//
//  Created by Yurii Boiko on 5/19/19.
//  Copyright © 2019 yurssoft. All rights reserved.
//

import UIKit

protocol RotatingCellDelegate: class {
    func didTapRotateButton(layer: CALayer, indexPath: IndexPath)
}

class RotatingCell: UICollectionViewCell {
    weak var delegate: RotatingCellDelegate?
    var cellIndexPath: IndexPath!
    @IBOutlet weak var rotatingButton: UIButton!
    func setupPolygon() {
        let ss = SimpleRegularPolygon()
        do {
            try ss.setNumber(of: Int.random(in: 3...11))
            ss.radius = Int(rotatingButton.frame.size.height/4)
            let shapeLayer = CAShapeLayer()
            let viewCenter = CGPoint(x: rotatingButton.frame.midX, y: rotatingButton.frame.midY)
            shapeLayer.path = ss.calculatePolygon(center: viewCenter)
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
    var randomNumber: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    @IBAction func rotatingButtonPressed(_ sender: Any) {
        delegate?.didTapRotateButton(layer: contentView.layer, indexPath: cellIndexPath)
    }
}
