//
//  GameUtility.swift
//  Snake
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit

class GameUtility {
    
    static func initializeGame() {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "IsInitialized") {
            defaults.set(true, forKey: "IsInitialized")
            defaults.set(true, forKey: "AudioKey")
            defaults.set(0, forKey: "HighScore")
        }
    }
    
    static func isAudioEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "AudioKey")
    }
    
    static func writeAudio(isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: "AudioKey")
        UserDefaults.standard.synchronize()
    }
        
    static func highScore() -> Int {
        return UserDefaults.standard.integer(forKey: "HighScore")
    }
    
    static func writeHighScore(highScore: Int) {
        UserDefaults.standard.set(highScore, forKey: "HighScore")
        UserDefaults.standard.synchronize()
    }
    
    static func snakeColor() -> UIColor {
        return UserDefaults.standard.value(forKey: "SnakeColor") as? UIColor ?? GameColor.snakeColor
    }
    
    static func writeSnakeColor(color: UIColor) {
        UserDefaults.standard.set(color, forKey: "SnakeColor")
        UserDefaults.standard.synchronize()
    }
}
