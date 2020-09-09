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
    var matrix:CellMatrix?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.matrix = CellMatrix(frame)
        Timer.scheduledTimer(withTimeInterval: 1.0,
            repeats: true,
            block: { (timer) in
               self.setNeedsDisplay()
            })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        matrix?.draw()
        matrix?.next()
    }
}

class CellMatrix {
    let frame: CGRect
    var gridModel:GridModel
    
    init(_ frame: CGRect) {
        var grid = [[Bool]](repeating: [Bool](repeating: false, count: 20), count: 20)
        for x in 0...19 {
            for y in 0...19 {
                if (
                    x == 10 && y == 10 ||
                    x == 11 && y == 10 ||
                    x == 9 && y == 11 ||
                    x == 10 && y == 11 ||
                    x == 10 && y == 12
                ) {
                    grid[x][y]  = true
                }
            }
        }
        self.gridModel = GridModel(grid: grid)
        self.frame = frame
    }
    
    func next() {
        gridModel = gridModel.nextGeneration()
    }
    
    func draw() {
        for i in 0...(gridModel.grid.count - 1) {
            for j in 0...(gridModel.grid.count - 1) {
                let house = HouseNumber(i,j)
                let cell = Cell(house, gridModel.grid[i][j])
                cell.draw(frame)
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

