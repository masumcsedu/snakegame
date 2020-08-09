//
//  BoardUtility.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

class BoardUtility {
    
    static func createCellList() -> [[Cell]] {
        
        let width = Constant.cellSize * CGFloat(Constant.boardColumn)
        let height = Constant.cellSize * CGFloat(Constant.boardRow)
        let halfWidth = width/2
        let halfHeight = height/2
        
        var cellList: [[Cell]] = []
        
        
        var y: CGFloat = halfHeight - (Constant.cellSize/2)
        for i in 0..<Constant.boardRow {
            
            var x: CGFloat = (Constant.cellSize/2) - halfWidth
            var list: [Cell] = []
            for j in 0..<Constant.boardColumn {
                
                let position = CGPoint(x: x, y: y)
                list.append(Cell(position: position, row: i, column: j))
                
                x += Constant.cellSize
            }
            
            cellList.append(list)
            y -= Constant.cellSize
            
        }
        
        return cellList
    }
    
    static func findNextCell(cell: Cell, direction: SnakeDirection, cellList: [[Cell]]) -> Cell? {
        switch direction {
        case .left:
            if cell.column > 0 {
                return cellList[cell.row][cell.column - 1]
            }
        case .right:
            if cell.column < (Constant.boardColumn - 1) {
                return cellList[cell.row][cell.column + 1]
            }
        case .up:
            if cell.row > 0 {
                return cellList[cell.row - 1][cell.column]
            }
        case .down:
            if cell.row < (Constant.boardRow - 1) {
                return cellList[cell.row + 1][cell.column]
            }
        }
        return nil
    }
    
    static func interpolate(start: CGPoint, end: CGPoint, progress: CGFloat) -> CGPoint {
        let remaining = 1.0 - progress
        let x = (start.x * remaining) + (end.x * progress)
        let y = (start.y * remaining) + (end.y * progress)
        return CGPoint(x: x, y: y)
    }
    
    static func interpolate(start: CGFloat, end: CGFloat, progress: CGFloat) -> CGFloat {
        let remaining = 1.0 - progress
        return (start * remaining) + (end * progress)
    }
    
    static func findRandomEmptyCell(cellList: [[Cell]]) -> Cell? {
        var emptyCell: Cell?
        while true {
            let randomRow = Int.random(in: 0..<Constant.boardRow)
            let randomColumn = Int.random(in: 0..<Constant.boardColumn)
            
            let randomCell = cellList[randomRow][randomColumn]
            if randomCell.type == .empty {
                emptyCell = randomCell
                break
            }
        }
        return emptyCell
    }
    
}
