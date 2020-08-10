//
//  SnakeTail.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeTail: SnakeOrgan {
    
    override var image: UIImage {UIImage(named: "tail")!}
    
    weak var previousOrgan: SnakeOrgan?
    var isFoodFound: Bool = false
    
    init(cell: Cell, direction: SnakeDirection, parentNode: SKNode?, previousOrgan: SnakeOrgan?) {
        self.previousOrgan = previousOrgan
        super.init(cell: cell, direction: direction, parentNode: parentNode)
    }
    
    override func move(nextCell: Cell, direction: SnakeDirection) {
        if isFoodFound {
            guard let previousOrgan = previousOrgan else {return}
            let body = SnakeBody(previousOrgan: previousOrgan)
            body.placeOnBoard()
            
            previousOrgan.next = body
            body.next = self
            self.previousOrgan = body
            
            isFoodFound = false
        } else {
            cell.type = .empty
            super.move(nextCell: nextCell, direction: direction)
        }
    }
    
}
