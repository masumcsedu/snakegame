//
//  Snake.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

enum SnakeDirection {
    case left, right, up, down
    
    var isVertical: Bool {self == .up || self == .up}
    var isHorizontal: Bool {self == .left || self == .right}
    var angle: CGFloat {
        switch self {
        case .left: return CGFloat.pi * 0.5
        case .right: return CGFloat.pi * 1.5
        case .up: return 0
        case .down: return CGFloat.pi
        }
    }
}

class Snake {
    
    let head: SnakeHead
    let tail: SnakeTail
    
    init(head: SnakeHead, tail: SnakeTail) {
        self.head = head
        self.tail = tail
    }
    
    func placeOnBoard() {
        head.placeOnBoard()
    }
    
    func move(nextCell: Cell, direction: SnakeDirection, isFoodFound: Bool) {
        tail.isFoodFound = isFoodFound
        head.move(nextCell: nextCell, direction: direction)
    }
    
    func finishMove() {
        head.finishMove()
    }
    
    func update(interval: TimeInterval, progress: CGFloat) {
        head.update(interval: interval, progress: progress)
    }
    
    func destroy() {
        head.destroy()
    }
}

extension Snake: CustomStringConvertible {
    var description: String {
        var list: [SnakeOrgan] = []
        var organ: SnakeOrgan? = head
        while organ != nil {
            list.append(organ!)
            organ = organ?.next
        }
        return "\(list)"
    }
}
