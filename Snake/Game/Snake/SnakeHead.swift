//
//  SnakeHead.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

class SnakeHead: SnakeOrgan {
    
    override var image: UIImage {UIImage(named: "head")!}
    
    override func move(nextCell: Cell, direction: SnakeDirection) {
        nextCell.type = .snake
        super.move(nextCell: nextCell, direction: direction)
    }
    
    func change(direction: SnakeDirection) {
        node?.zRotation = direction.angle
    }
}
