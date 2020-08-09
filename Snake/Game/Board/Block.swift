//
//  Block.swift
//  Snake
//
//  Created by Shamsur Rahman on 8/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import SpriteKit

class Block {
    
    var cell: Cell
    weak var parentNode: SKNode?
    
    var node: SKNode?
    var image: UIImage {UIImage(named: "rock")!}
    
    init(cell: Cell, parentNode: SKNode?) {
        self.cell = cell
        self.parentNode = parentNode
    }
    
    func placeOnCell() {
        let node = SKSpriteNode(texture: SKTexture(image: image), size: CGSize(width: Constant.cellSize, height: Constant.cellSize))
        node.position = cell.position
        parentNode?.addChild(node)
        self.node = node
        cell.type = .block
    }
    
    func destroy() {
        node?.removeFromParent()
        node = nil
        cell.type = .empty
    }
}
