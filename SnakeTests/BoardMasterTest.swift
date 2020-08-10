//
//  BoardMasterTest.swift
//  SnakeTests
//
//  Created by Shamsur Rahman on 10/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import XCTest

class BoardMasterTest: XCTestCase, BoardMasterDelegate {
    
    var finishAnimationExpectation: XCTestExpectation?
    var findFoodExpectation: XCTestExpectation?
    var findCollsionExpectation: XCTestExpectation?
    
    var boardMaster: BoardMaster?

    override func setUp() {
        boardMaster = BoardMaster(delegate: self)
    }

    override func tearDown() {
        boardMaster = nil
    }
    
    func testUpdateAnimationFinish() {
        finishAnimationExpectation = expectation(description: "FinishAnimation")
        
        boardMaster?.update(interval: Constant.animationDuration + 0.1)
        
        waitForExpectations(timeout: 0)
    }
    
    func testSnakeMoveToFood() {
        findFoodExpectation = expectation(description: "FindFood")
        
        createSnake()
        boardMaster?.cellList[19][15].type = .food
        
        boardMaster?.moveSnake(direction: .up)
        
        waitForExpectations(timeout: 0)
    }

    func testSnakeMoveToBlock() {
        findCollsionExpectation = expectation(description: "FindCollsion")
        
        createSnake()
        boardMaster?.cellList[19][15].type = .block
        
        boardMaster?.moveSnake(direction: .up)
        
        waitForExpectations(timeout: 0)
    }
    
    func createSnake() {
        let headCell = boardMaster?.cellList[20][15]
        let bodyCell = boardMaster?.cellList[21][15]
        let tailCell = boardMaster?.cellList[22][15]
        
        headCell?.type = .snake
        bodyCell?.type = .snake
        tailCell?.type = .snake
        
        let head = SnakeHead(cell: headCell!, direction: .up, parentNode: nil)
        let body = SnakeBody(cell: bodyCell!, direction: .up, parentNode: nil)
        let tail = SnakeTail(cell: tailCell!, direction: .up, parentNode: nil, previousOrgan: body)
        
        head.next = body
        body.next = tail
        
        boardMaster?.snake = Snake(head: head, tail: tail)
    }
    
    func boardMasterDidFinishMove() {
        finishAnimationExpectation?.fulfill()
    }
    
    func boardMasterDidFindFood(cell: Cell) {
        findFoodExpectation?.fulfill()
    }
    
    func boardMasterDidFindCollsion() {
        findCollsionExpectation?.fulfill()
    }

}
