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

    func nextGeneration() -> GridModel {
        var newGrid = [[Bool]]()
        for item in grid {
            newGrid.append(Array(repeating: false, count: item.count))
        }

        for row in 1...grid.count - 1 {
            for col in 1...grid[row].count - 1 {
                var aliveNeighbours = 0
                for i in -1...1 {
                    for j in -1...1 {
                        if (row + i) < grid.count && (col + j) < grid[row].count {
                            if grid[row + i][col + j] {
                                aliveNeighbours += 1
                            }
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

        return GridModel(grid: newGrid)
    }
}
