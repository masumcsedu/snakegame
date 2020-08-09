//
//  Extensions.swift
//  Snake
//
//  Created by Shamsur Rahman on 8/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

extension CGPoint {
    
    func distance(from point: CGPoint) -> CGFloat {
        let dx = x - point.x
        let dy = y - point.y
        
        return sqrt(pow(dx, 2) + pow(dy, 2))
    }
    
    func negetive() -> CGPoint {
        return CGPoint(x: -x, y: -y)
    }
    
}
