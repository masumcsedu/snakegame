//
//  MainMenuScene.swift
//  Snake
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    let mainMenu: SKSpriteNode
    
    var leaderboardButton: SKSpriteNode!
    var audioButton: SKSpriteNode!
    
    override init(size: CGSize) {
        mainMenu = SKSpriteNode(color: UIColor.clear, size: size)
        super.init(size: size)
        createSceneUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        prepareScene()
    }
    
    func createSceneUI() {
        let global = Global.shared
        
        self.backgroundColor = GameColor.bgColor
        mainMenu.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(mainMenu)
        
        let title = SceneUtility.titleLabel(text: "Snake & Food")
        
        let topBarHeight: CGFloat = 75
        let width = size.width
        let topBarY = ((size.height/2) - global.safeAreaInset.top) - 37.5
        var maxWidth = width - 20
        
        if maxWidth > 350 {
            maxWidth = 350
        }
        let widthScale: CGFloat = maxWidth/350
        let playButtonHeight: CGFloat = 100 * widthScale
        let titleY = topBarY/2
        
        let menuLayout: [[String : Any?]] = [
            ["color": UIColor.clear,    "frame": CGRect(x: 0, y: topBarY, width: width, height: topBarHeight), "title":"MenuTopBarNode"],
            ["node": title,             "frame": CGRect(x: 0, y: titleY, width: maxWidth, height: 50), "title":"GameTitleNode"],
            ["name": "PlayButton",      "frame": CGRect(x: 0, y: 0, width: maxWidth, height: playButtonHeight), "title":"PlayButtonNode"],
            ["color": UIColor.clear,    "frame": CGRect(x: 0, y: -202.5, width: width, height: 65), "title":"ButtonBarNode"]
        ]
        
        
        let buttonWidth: CGFloat = 65
        let spacing: CGFloat = maxWidth - (2 * buttonWidth)
        let x: CGFloat = (buttonWidth + spacing) * 0.5
        
        let buttonLayout: [[String : Any?]] = [
            [                           "frame": CGRect(x: -x, y: 0, width: 65, height: 65), "title":"AudioButtonNode"],
            ["name": "Leaderboard",     "frame": CGRect(x: x, y: 0, width: 65, height: 65), "title":"LeaderboardButtonNode"],
        ]
        
        SceneUtility.addNodes(on: mainMenu, from: menuLayout)
        
        let buttonBar = mainMenu.childNode(withName: "ButtonBarNode")
        SceneUtility.addNodes(on: buttonBar!, from: buttonLayout)
        audioButton  = buttonBar?.childNode(withName: "AudioButtonNode") as! SKSpriteNode?
        leaderboardButton  = buttonBar?.childNode(withName: "LeaderboardButtonNode") as! SKSpriteNode?
        
        let topBar = mainMenu.childNode(withName: "MenuTopBarNode")
        
        global.highScoreNode1 = SceneUtility.createLabel(text: "High Score \(global.highScore)")
        
        let barLayout: [[String : Any?]] = [
            ["node": global.highScoreNode1, "frame": CGRect(x: 0, y: 0, width: 200, height: 40), "title":"HighScoreTextNode"]
        ]
        
        SceneUtility.addNodes(on: topBar!, from: barLayout)
        
    }
    
    func prepareScene() {
        Global.shared.currentScene = self
        updateAudioIcon()
    }
    
    func updateAudioIcon() {
        if Global.shared.isAudioEnabled {
            audioButton.texture = SKTexture(image: UIImage(named: "AudioOn")!)
        } else {
            audioButton.texture = SKTexture(image: UIImage(named: "AudioOff")!)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else {
            return
        }
        guard let node = self.nodes(at: location).first else {
            return
        }
        guard let nodeName = node.name else {
            return
        }
        
        var shouldPlaySound = true
        
        if nodeName == "PlayButtonNode" {
            self.view?.presentScene(Global.shared.gameScene, transition: SKTransition.doorway(withDuration: 0.5))
        } else if nodeName == "AudioButtonNode" {
            Global.shared.toggleSound()
            updateAudioIcon()
        } else if nodeName == "LeaderboardButtonNode" {
            GameKitHelper.shared.showLeaderboard()
        } else {
            shouldPlaySound = false;
        }
        
        if shouldPlaySound {
            Global.shared.playSound(name: "MenuClick")
        }
    }
}
