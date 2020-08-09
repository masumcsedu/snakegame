//
//  Cell.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

enum CellType {
    case empty, food, snake, block
}

class Cell {
    var type: CellType = .empty
    let position: CGPoint
    let row: Int
    let column: Int
    
    init(position: CGPoint, row: Int, column: Int) {
        self.position = position
        self.row = row
        self.column = column
    }
}

extension Cell: Equatable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}

extension Cell: CustomStringConvertible {
    var description: String {
        "type: \(type), row: \(row), column: \(column), position: \(position)"
    }
}
