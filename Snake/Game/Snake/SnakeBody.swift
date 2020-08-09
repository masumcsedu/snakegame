//
//  SnakeBody.swift
//  Snake
//
//  Created by Shamsur Rahman on 7/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

class SnakeBody: SnakeOrgan {
    override var image: UIImage {UIImage(named: "body")!}
    
    convenience init(previousOrgan: SnakeOrgan) {
        self.init(cell: previousOrgan.cell, direction: previousOrgan.direction, parentNode: previousOrgan.parentNode)
    }
}
