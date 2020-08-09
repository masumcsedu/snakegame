//
//  Constants.swift
//  Snake
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

struct Constant {
    static let borderStrokeWidth: CGFloat = 10
    static let cellStrokeWidth: CGFloat = 1
    static let cellSize: CGFloat = 28
    static let boardColumn: Int = 31
    static let boardRow: Int = 51
    
    static let animationDuration: TimeInterval = 0.3
    static let minDeltaTime: TimeInterval = 0.05 // atleast fps 20
    static let dragOffset: CGFloat = 50
    
    static let initialFoodCount: Int = 5
    static let maxFoodCountOnBoard: Int = 15
    static let foodAddInterval: TimeInterval = 3
    
    static let blockMaxLimit: Int = 10
    static let blockMinLimit: Int = 2
}

struct GameColor {
    static let snakeColor = UIColor.green
    static let bgColor = UIColor(white: 0.12, alpha: 1.0)
    static let gameBoardColor = UIColor(red: 0.09, green: 0.1, blue: 0.13, alpha: 1.0)
    
    static let borderStrokeColor = UIColor.red
    static let cellStrokeColor = UIColor.white
    static let gameBarColor = UIColor(white: 1.0, alpha: 0.75)
    static let gameMenuColor = UIColor(white: 0.25, alpha: 0.50)
}
