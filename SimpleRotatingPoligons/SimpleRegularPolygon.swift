//
//  SimpleRegularPolygon.swift
//  SimpleRotatingPoligons
//
//  Created by Yurii Boiko on 5/19/19.
//  Copyright © 2019 yurssoft. All rights reserved.
//

import CoreGraphics

class SRPError: Swift.Error {
    var error = ""
    
    init(error: String) {
        self.error = error
    }
}

class SimpleRegularPolygon: NSObject {
    var sides: Int!
    var radius: Int!
    
    func deegresBetweenTwoVertices() -> Int {
        return 360 / sides
    }
    
    func setNumber(of sides: Int) throws {
        guard sides >= 3 else {
            throw SRPError(error: "Set two sides or more")
        }
        self.sides = sides
    }
    
    func calculatePolygon(center: CGPoint) -> CGPath {
        let path = CGMutablePath()
        let degreesBetweenSides = Float(360 / sides)
        let radiansAngleBetweenSides = (Float.pi * degreesBetweenSides) / 180
        for index in 0...sides {
            let cosVal = CGFloat(cos(radiansAngleBetweenSides * Float(index)))
            let xCoordinate = center.x + CGFloat(radius) * cosVal
            let sinVal = CGFloat(sin(radiansAngleBetweenSides * Float(index)))
            let yCoordinate = center.y + CGFloat(radius) * sinVal
            let point = CGPoint(x: xCoordinate, y: yCoordinate)
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}
