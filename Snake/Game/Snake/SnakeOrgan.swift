//
//  SnakeOrgan.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import SpriteKit

class SnakeOrgan {
    
    var cell: Cell
    var direction: SnakeDirection
    weak var parentNode: SKNode?
    
    var nextCell: Cell?
    
    var previousDirection: SnakeDirection
    
    var currentPosition: CGPoint = .zero
    var nextPosition: CGPoint?
    
    var currentAngle: CGFloat
    var nextAngle: CGFloat?
    
    var node: SKNode?
    var next: SnakeOrgan?
    
    // override this property from subclass
    var image: UIImage {UIImage()}
    
    init(cell: Cell, direction: SnakeDirection, parentNode: SKNode?) {
        self.cell = cell
        self.direction = direction
        self.parentNode = parentNode
        previousDirection = direction
        currentAngle = direction.angle
    }
    
    func placeOnBoard() {
        
        let node = SKSpriteNode(texture: SKTexture(image: image), size: CGSize(width: Constant.cellSize, height: Constant.cellSize))
        node.position = cell.position
        parentNode?.addChild(node)
        self.node = node
        cell.type = .snake
        currentPosition = cell.position
        node.zRotation = direction.angle
        
        next?.placeOnBoard()
    }
    
    func update(interval: TimeInterval, progress: CGFloat) {
        if let nextPosition = nextPosition {
            let position = BoardUtility.interpolate(start: currentPosition, end: nextPosition, progress: progress)
            node?.position = position
        }
        
        if let nextAngle = nextAngle {
            let rotation = BoardUtility.interpolate(start: currentAngle, end: nextAngle, progress: progress)
            node?.zRotation = rotation
        }
        
        next?.update(interval: interval, progress: progress)
    }
    
    func move(nextCell: Cell, direction: SnakeDirection) {
        previousDirection = self.direction
        
        if previousDirection == direction {
            nextAngle = nil
        } else {
            currentAngle = previousDirection.angle
            nextAngle = direction.angle
            if previousDirection == .up && direction == .right {
                currentAngle = CGFloat.pi * 2.0
            } else if previousDirection == .right && direction == .up {
                nextAngle = CGFloat.pi * 2.0
            }
        }
        
        self.nextCell = nextCell
        self.direction = direction
        nextPosition = nextCell.position
        
        next?.move(nextCell: cell, direction: previousDirection)
    }
    
    func finishMove() {
        if let nextCell = nextCell {
            cell = nextCell
            self.nextCell = nil
            currentPosition = cell.position
            nextPosition = nil
            node?.position = currentPosition
            node?.zRotation = direction.angle
            currentAngle = direction.angle
            nextAngle = nil
        }
        
        next?.finishMove()
    }
    
    func destroy() {
        node?.removeFromParent()
        node = nil
        next?.destroy()
    }
    
}

extension SnakeOrgan: CustomStringConvertible {
    var description: String {
        "direction: \(direction), row: \(cell.row), column: \(cell.column), position: \(cell.position)"
    }
}
