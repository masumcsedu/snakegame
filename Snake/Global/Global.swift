//
//  Global.swift
//  Snake
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import SpriteKit

class Global {
    static var shared: Global = Global()
    
    // Scene
    var mainMenuScene: MainMenuScene!
    var gameScene: GameScene!
    
    //Sound
    weak var currentScene: SKScene?
    
    // UI element
    var highScoreNode1: SKLabelNode!
    var highScoreNode2: SKLabelNode!
    var scoreNode: SKLabelNode!
    
    var safeAreaInset: UIEdgeInsets {
        if let window = UIApplication.shared.windows.first {
            if #available(iOS 11, *) {
                let standardSpacing: CGFloat = 8
                let top = window.layoutMargins.top - standardSpacing
                let left = window.layoutMargins.left - standardSpacing
                let bottom = window.layoutMargins.bottom - standardSpacing
                let right = window.layoutMargins.right - standardSpacing
                return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
            }
        }
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private var _isAudioEnabled: Bool
    var isAudioEnabled: Bool {
        get {
            return _isAudioEnabled
        }
        set(newValue) {
            _isAudioEnabled = newValue
            GameUtility.writeAudio(isEnabled: newValue)
        }
    }
    
    private var _highScore: Int
    var highScore: Int {
        get {
            return _highScore
        }
        set(newValue) {
            _highScore = newValue
            GameUtility.writeHighScore(highScore: newValue)
            highScoreNode1.text = "High Score \(_highScore)"
            highScoreNode2.text = "High Score \(_highScore)"
        }
    }
    
    private var _score: Int
    var score: Int {
        get {
            return _score
        }
        set(newValue) {
            _score = newValue
            scoreNode.text = "\(_score)"
            
            if _score > _highScore {
                highScore = _score
                GameKitHelper.shared.reportHighScore(score: Int64(highScore))
            }
        }
    }
    
    
    init() {
        GameUtility.initializeGame()
        _isAudioEnabled = GameUtility.isAudioEnabled()
        _highScore = GameUtility.highScore()
        _score = 0
    }
    
    func prepare() {
        mainMenuScene = MainMenuScene(size: UIScreen.main.bounds.size)
        mainMenuScene.scaleMode = .aspectFit
        
        gameScene = GameScene(size: UIScreen.main.bounds.size)
        gameScene.scaleMode = .aspectFit
    }
    
    func toggleSound() {
        self.isAudioEnabled = !_isAudioEnabled
    }
    
    func playSound(name: String) {
        if self.isAudioEnabled {
            currentScene?.run(SKAction.playSoundFileNamed(name, waitForCompletion: false))
        }
    }
}
