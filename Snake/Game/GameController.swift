//
//  GameController.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

protocol GameControllerDelegate: class {
    func controllerDidFinishGame()
}

class GameController {
    
    weak var delegate: GameControllerDelegate?
    var boardMaster: BoardMaster!
    
    var isGameRunning = false
    var time: TimeInterval = 0
    var direction: SnakeDirection = .up
    var pendingDirection: SnakeDirection?
    var isDirectionChangeWaitingForUse: Bool = false
    var timeSinceMove: TimeInterval = 0
    
    init(delegate: GameControllerDelegate) {
        self.delegate = delegate
        
        boardMaster = BoardMaster(delegate: self)
    }
    
    func startGame() {
        start()
    }
    
    func update(_ currentTime: TimeInterval) {
        var dt: TimeInterval = currentTime - time
        if dt > Constant.minDeltaTime {
            dt = Constant.minDeltaTime
        }
        timeSinceMove += dt
        boardMaster.update(interval: timeSinceMove)
    }
    
    func changeDirection(direction: SnakeDirection) -> Bool {
        guard self.direction.isHorizontal != direction.isHorizontal && pendingDirection == nil else {return false}
        guard !isDirectionChangeWaitingForUse else {
            pendingDirection = direction
            return true
        }
        isDirectionChangeWaitingForUse = true
        self.direction = direction
        return true
    }
    
    func playAgain() {
        resetGame()
        start()
    }
    
    func resetGame() {
        isGameRunning = false
        time = 0
        direction = .up
        pendingDirection = nil
        isDirectionChangeWaitingForUse = false
        timeSinceMove = 0
        
        boardMaster.clearBoard()
    }
    
    private func start() {
        Global.shared.score = 0
        
        boardMaster.setupBoard(direction: direction)
        boardMaster.startBoard(direction: direction)
        isGameRunning = true
    }
    
}

extension GameController: BoardMasterDelegate {
    
    func boardMasterDidFinishMove() {
        if isGameRunning {
            boardMaster.finishMove()
        }
        isDirectionChangeWaitingForUse = false
        if let pendingDirection = pendingDirection {
            self.direction = pendingDirection
            self.pendingDirection = nil
        }
        
        boardMaster.moveSnake(direction: direction)
        timeSinceMove = 0
    }
    
    func boardMasterDidFindFood(cell: Cell) {
        Global.shared.score += 10
        Global.shared.playSound(name: "EatFood")
        boardMaster.eatFood(cell: cell)
    }
    
    func boardMasterDidFindCollsion() {
        isGameRunning = false
        delegate?.controllerDidFinishGame()
        Global.shared.playSound(name: "Collision")
        boardMaster.stopBoard()
    }
}

