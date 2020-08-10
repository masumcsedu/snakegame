//
//  SnakeTests.swift
//  SnakeTests
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import XCTest
@testable import Snake

class SnakeTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testFood() {
        let cell = Cell(position: .zero, row: 0, column: 0)
        let food = Food(cell: cell, parentNode: nil)
        food.placeOnCell()
        
        XCTAssert(cell.type == .food, "After placing food on cell doesn't change cell type.")
    }
    
    func testBlock() {
        let cell = Cell(position: .zero, row: 0, column: 0)
        let block = Block(cell: cell, parentNode: nil)
        block.placeOnCell()
        
        XCTAssert(cell.type == .block, "After placing block on cell doesn't change cell type.")
    }
    
    func testSnake() {
        
        let headCell = Cell(position: .zero, row: 0, column: 0)
        let bodyCell = Cell(position: .zero, row: 1, column: 0)
        let tailCell = Cell(position: .zero, row: 2, column: 0)
        
        let head = SnakeHead(cell: headCell, direction: .up, parentNode: nil)
        let body = SnakeBody(cell: bodyCell, direction: .up, parentNode: nil)
        let tail = SnakeTail(cell: tailCell, direction: .up, parentNode: nil, previousOrgan: body)
        
        head.next = body
        body.next = tail
        
        let snake = Snake(head: head, tail: tail)
        snake.placeOnBoard()
        
        XCTAssert(headCell.type == .snake, "After placing snake head on cell doesn't change cell type.")
        XCTAssert(bodyCell.type == .snake, "After placing snake body on cell doesn't change cell type.")
        XCTAssert(tailCell.type == .snake, "After placing snake tail on cell doesn't change cell type.")
    }

}
