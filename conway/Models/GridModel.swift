//
//  GridModel.swift
//  conway
//
//  Created by Evelyn Loo on 7/9/20.
//  Copyright © 2020 Zuhlke. All rights reserved.
//

import UIKit

class GridModel: NSObject {
    var grid = [[Bool]]()

    init(grid: [[Bool]]) {
        self.grid = grid
        super.init()
    }

    func nextGeneration() -> [[Bool]] {
        var newGrid = [[Bool]]()
        for row in 1...grid.count {
            for col in 1...grid[row].count {
                var aliveNeighbours = 0
                for i in -1...1 {
                    for j in -1...1 {
                        if grid[row + i][col + j] {
                            aliveNeighbours += 1
                        }
                    }
                }

                if grid[row][col] {
                    aliveNeighbours -= 1
                }

                if grid[row][col] && aliveNeighbours < 2 {
                    newGrid[row][col] = false
                } else if grid[row][col] && aliveNeighbours > 3 {
                    newGrid[row][col] = false
                } else if !grid[row][col] && aliveNeighbours == 3 {
                    newGrid[row][col] = true
                } else {
                    newGrid[row][col] = grid[row][col]
                }
            }
        }

        return newGrid
    }
}
