//
//  ViewController.swift
//  conway
//
//  Created by Rob Moore on 7/9/20.
//  Copyright © 2020 Zuhlke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        let k = Draw(frame: CGRect(
          origin: CGPoint(x: 0, y: 100),
          size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)))
        
        // Add the view to the view hierarchy so that it shows up on screen
        self.view.addSubview(k)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class Draw: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Draw all our stuff
        
        for i in 0...20 {
            for j in 0...20 {
                let isAlive = (i+j) % 5 == 0
                Cell(HouseNumber(i, j), isAlive).draw(frame)
            }
        }
    }
}

class Cell {
    let alive:UIColor = UIColor.white
    let dead:UIColor = UIColor.gray
    
    let houseNumber: HouseNumber
    let isAlive: Bool
    
    init(_ houseNumber: HouseNumber, _ isAlive: Bool) {
        self.houseNumber = houseNumber
        self.isAlive = isAlive
    }
    
    func draw(_ frame: CGRect) {
        let sideLength = frame.width
        let firstGrayBox = CGRect(x: houseNumber.xCoordinate(sideLength), y: houseNumber.yCoordinate(sideLength), width: frame.width / 25, height: frame.width / 25)
        let firstGrayBoxBezierPath: UIBezierPath = UIBezierPath(rect: firstGrayBox)
        if (isAlive) {
          alive.set()
        } else {
          dead.set()
        }
        firstGrayBoxBezierPath.stroke()
        firstGrayBoxBezierPath.fill()
    }
}

class HouseNumber {
    let x: CGFloat
    let y: CGFloat
    
    init(_ x: Int, _ y: Int) {
        self.x = CGFloat(integerLiteral: x)
        self.y = CGFloat(integerLiteral: y)
    }
    
    func xCoordinate(_ sideLength: CGFloat) -> CGFloat {
        return 1 + x*2 + (x * (sideLength / 25))
    }
    
    func yCoordinate(_ sideLength: CGFloat) -> CGFloat {
        return 1 + y*2 + (y * (sideLength / 25))
    }
}

