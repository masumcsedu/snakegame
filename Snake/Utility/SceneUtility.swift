//
//  SceneUtility.swift
//  Snake
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import SpriteKit

class SceneUtility {
    
    static func addNodes(on parentNode:SKNode, from list:[[String:Any?]]) {
        for nodeDetail in list {
            var node: SKNode!
            
            guard let frame: CGRect = nodeDetail["frame"] as? CGRect else {
                return
            }
            
            if let name = nodeDetail["name"] as? String {
                node = SKSpriteNode(texture: SKTexture(image: UIImage(named: name)!), size: frame.size)
            } else if let image = nodeDetail["image"] as? UIImage {
                node = SKSpriteNode(texture: SKTexture(image: image), size: frame.size)
            } else if let color = nodeDetail["color"] as? UIColor {
                node = SKSpriteNode(color: color, size: frame.size)
            } else if let newNode = nodeDetail["node"] as? SKNode {
                node = newNode
            } else {
                node = SKSpriteNode(texture: nil, size: frame.size)
            }
            
            node.position = frame.origin
            node.name = nodeDetail["title"] as? String
            parentNode.addChild(node)
        }
    }
    
    static func createLabel(text:String, fontSize: CGFloat = 24, color: UIColor = .white) -> SKLabelNode {
        let labelNode = SKLabelNode(text: text)
        labelNode.fontColor = color
        labelNode.fontSize = 24
        labelNode.verticalAlignmentMode = .center
        labelNode.horizontalAlignmentMode = .center
        return labelNode
    }
    
    static func titleLabel(text:String) -> SKLabelNode {
        let labelNode = SKLabelNode(fontNamed: UIFont.boldSystemFont(ofSize: 48).fontName)
        labelNode.text = text
        labelNode.fontColor = .brown
        labelNode.verticalAlignmentMode = .center
        labelNode.horizontalAlignmentMode = .center
        return labelNode
    }
    
}
