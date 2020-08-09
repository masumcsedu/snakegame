//
//  Food.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import SpriteKit

class Food {
    
    var cell: Cell
    weak var parentNode: SKNode?
    
    var node: SKNode?
    var image: UIImage {UIImage(named: "orange")!}
    
    init(cell: Cell, parentNode: SKNode?) {
        self.cell = cell
        self.parentNode = parentNode
    }
    
    func placeOnCell() {
        let node = SKSpriteNode(texture: SKTexture(image: image), size: CGSize(width: Constant.cellSize, height: Constant.cellSize))
        node.position = cell.position
        parentNode?.addChild(node)
        self.node = node
        cell.type = .food
    }
    
    func destroy() {
        node?.removeFromParent()
        node = nil
        cell.type = .empty
    }
}
