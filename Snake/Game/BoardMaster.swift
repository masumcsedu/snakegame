//
//  BoardMaster.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import SpriteKit

protocol BoardMasterDelegate: class {
    func boardMasterDidFinishMove()
    func boardMasterDidFindFood(cell: Cell)
    func boardMasterDidFindCollsion()
}

class BoardMaster {
    
    weak var delegate: BoardMasterDelegate?
    var boardNode: SKNode?
    
    var cellList: [[Cell]]
    var snake: Snake?
    
    var timer: Timer?
    var foodList: [Food] = []
    var blockList: [Block] = []
    
    var currentPosition: CGPoint = .zero
    var nextPosition: CGPoint?
    
    var blockCells: [Cell] = []

    init(delegate: BoardMasterDelegate) {
        self.delegate = delegate
        cellList = BoardUtility.createCellList()
    }
    
    func setupBoard(direction: SnakeDirection) {
        addSnakeOnBoard(direction: direction)
        addBlockOnBoard()
        for _ in 0..<Constant.initialFoodCount {
            addFoodOnBoard()
        }
    }
    
    func startBoard(direction: SnakeDirection) {
        startFoodTimer()
        moveSnake(direction: direction)
    }
    
    func update(interval: TimeInterval) {
        
        var progress = CGFloat(interval / Constant.animationDuration)
        
        guard progress < 1.0 else {
            progress = 1.0
            delegate?.boardMasterDidFinishMove()
            return
        }
        
        // Move Board along with snake movement
        if let nextPosition = nextPosition {
            let position = BoardUtility.interpolate(start: currentPosition, end: nextPosition, progress: progress)
            boardNode?.position = position
        }
        
        // Move snake
        snake?.update(interval: interval, progress: progress)
    }
    
    func eatFood(cell: Cell) {
        
        guard let index = foodList.firstIndex(where: {$0.cell == cell}) else {return}
        
        let food = foodList[index]
        
        if let explosionPath = Bundle.main.path(forResource: "FoodSpark", ofType: "sks"),
            let explosion = NSKeyedUnarchiver.unarchiveObject(withFile: explosionPath) as? SKEmitterNode {
            
            explosion.position = food.cell.position
            boardNode?.addChild(explosion)
            explosion.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.removeFromParent()]))
        }
        
        food.destroy()
        foodList.remove(at: index)
    }
    
    func moveSnake(direction: SnakeDirection) {
        guard let snake = snake else {return}
        let snakeCell = snake.head.cell
        guard let nextCell = BoardUtility.findNextCell(cell: snakeCell, direction: direction, cellList: cellList) else {
            delegate?.boardMasterDidFindCollsion()
            snake.changeHead(direction: direction)
            return
        }
        
        var isValidMove: Bool = true
        var isFoodFound: Bool = false
        switch nextCell.type {
        case .empty:
            break
        case .snake, .block:
            isValidMove = false
            delegate?.boardMasterDidFindCollsion()
        case .food:
            delegate?.boardMasterDidFindFood(cell: nextCell)
            isFoodFound = true
        }
        
        if isValidMove {
            snake.move(nextCell: nextCell, direction: direction, isFoodFound: isFoodFound)
        } else {
            snake.changeHead(direction: direction)
        }
        
        nextPosition = nextCell.position.negetive()
    }
    
    func finishMove() {
        if let nextPosition = nextPosition {
            currentPosition = nextPosition
            self.nextPosition = nil
        }
        snake?.finishMove()
    }
    
    func stopBoard() {
        stopFoodTimer()
    }
    
    func clearBoard() {
        stopBoard()
        removeFoods()
        removeSnake()
        removeBlock()
        cellList = BoardUtility.createCellList()
    }
    
    private func startFoodTimer() {
        timer = Timer.scheduledTimer(timeInterval: Constant.foodAddInterval,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func tick() {
        addFoodOnBoard()
    }
    
    private func stopFoodTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func addSnakeOnBoard(direction: SnakeDirection) {
        
        let centerRow: Int = Constant.boardRow / 2
        let centerColumn: Int = Constant.boardColumn / 2
        
        let headCell = cellList[centerRow][centerColumn]
        let bodyCell = cellList[centerRow + 1][centerColumn]
        let tailCell = cellList[centerRow + 2][centerColumn]
        
        let head = SnakeHead(cell: headCell, direction: direction, parentNode: boardNode)
        let body = SnakeBody(cell: bodyCell, direction: direction, parentNode: boardNode)
        let tail = SnakeTail(cell: tailCell, direction: direction, parentNode: boardNode, previousOrgan: body)
        
        head.next = body
        body.next = tail
        
        let snake = Snake(head: head, tail: tail)
        snake.placeOnBoard()
        
        currentPosition = headCell.position
        
        self.snake = snake
    }
    
    private func removeSnake() {
        snake?.destroy()
        snake = nil
    }
    
    private func addFoodOnBoard() {
        
        guard foodList.count < Constant.maxFoodCountOnBoard else {
            return
        }
        
        guard let cell = BoardUtility.findRandomEmptyCell(cellList: cellList) else {
            return
        }
        
        let food = Food(cell: cell, parentNode: boardNode)
        food.placeOnCell()
        foodList.append(food)
    }
    
    private func removeFoods() {
        foodList.forEach {$0.destroy()}
        foodList.removeAll()
    }
    
    private func addBlockOnBoard() {
        let blockCount = Int.random(in: Constant.blockMinLimit...Constant.blockMaxLimit)
        
        var count = 0
        while count < blockCount {
            guard let cell = BoardUtility.findRandomEmptyCell(cellList: cellList) else {
                continue
            }
            
            let block = Block(cell: cell, parentNode: boardNode)
            block.placeOnCell()
            blockList.append(block)
            
            count += 1
        }
    }
    
    private func removeBlock() {
        blockList.forEach {$0.destroy()}
        blockList.removeAll()
    }
}
