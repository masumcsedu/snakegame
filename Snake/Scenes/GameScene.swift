//
//  GameScene.swift
//  Snake
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let global: Global
    let backgroundNode: SKSpriteNode
    var gameOverMenu: SKSpriteNode!
    
    var touchBeginPosition: CGPoint?
    
    var gameController: GameController!
    
    override init(size: CGSize) {
        global = Global.shared
        backgroundNode = SKSpriteNode(texture: SKTexture(image: UIImage(named: "background")!), size: size)
        
        super.init(size: size)
        
        gameController = GameController(delegate: self)
        
        createSceneUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        prepareScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameController.isGameRunning {
            gameController.update(currentTime)
        }
        gameController.time = currentTime
    }
    
    func createSceneUI() {
        self.backgroundColor = GameColor.bgColor
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(backgroundNode)
        
        createMenu()
        
        let topBarHeight: CGFloat = 75
        let width = size.width
        let topBarY = ((size.height/2) - global.safeAreaInset.top) - (topBarHeight/2)
        
        let image = ImageUtility.createBackgroundImage()
        
        let controllerY = (Global.shared.safeAreaInset.bottom + 20 + 65) - (size.height/2)
        let controllerX = (size.width/2) - (20 + 65)
        
        let gameLayout: [[String : Any?]] = [
            ["image": image,                    "frame": CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height),  "title":"GameBoardNode"],
            ["color": GameColor.gameBarColor,   "frame": CGRect(x: 0, y: topBarY, width: width, height: topBarHeight),  "title":"GameTopBarNode"],
            ["color": UIColor.clear,            "frame": CGRect(x: controllerX, y: controllerY, width: 130, height: 130), "title":"GameControllerNode"]
        ]
        
        SceneUtility.addNodes(on: backgroundNode, from: gameLayout)
        
        gameController.boardMaster.boardNode = backgroundNode.childNode(withName: "GameBoardNode")
        let topBar = backgroundNode.childNode(withName: "GameTopBarNode")
        let gameController = backgroundNode.childNode(withName: "GameControllerNode")
        
        // Top Bar
        global.scoreNode = SceneUtility.createLabel(text: "0", fontSize: 32, color: .black)
        global.scoreNode.horizontalAlignmentMode = .center
        global.highScoreNode2 = SceneUtility.createLabel(text: "High Score \(global.highScore)", color: .black)
        global.highScoreNode2.horizontalAlignmentMode = .right
        
        
        let halfWidth = width/2
        let barLayout: [[String : Any?]] = [
            ["name": "left",      "frame": CGRect(x: 35 - halfWidth, y: 0, width: 45, height: 45), "title":"BackButtonNode"],
            ["node": global.scoreNode!, "frame": CGRect(x: 0, y: 0, width: 100, height: 40), "title":"ScoreTextNode"],
            ["node": global.highScoreNode2!, "frame": CGRect(x: halfWidth - 10, y: 0, width: 200, height: 40), "title":"HighScoreTextNode"]
        ]
        
        SceneUtility.addNodes(on: topBar!, from: barLayout)
        
        let controllerLayout: [[String : Any?]] = [
            ["name": "left",      "frame": CGRect(x: -40, y: 0, width: 50, height: 50), "title":"LeftControlButtonNode"],
            ["name": "right",      "frame": CGRect(x: 40, y: 0, width: 50, height: 50), "title":"RightControlButtonNode"],
            ["name": "up",      "frame": CGRect(x: 0, y: 40, width: 50, height: 50), "title":"UpControlButtonNode"],
            ["name": "down",      "frame": CGRect(x: 0, y: -40, width: 50, height: 50), "title":"DownControlButtonNode"]
        ]
        
        SceneUtility.addNodes(on: gameController!, from: controllerLayout)
    }
    
    func prepareScene() {
        Global.shared.currentScene = self
        
        gameController.startGame()
    }
    
    private func createMenu() {
        var buttonWidth = size.width - 20
        if buttonWidth > 320 {
            buttonWidth = 320
        }
        let widthScale: CGFloat = buttonWidth/320
        let buttonHeight = widthScale * 60
        let offsetY = (buttonHeight/2) + 20
        let menuHeight = (buttonHeight * 2) + 80 // Space 80 = 20 + 40 +20
        gameOverMenu = SKSpriteNode(color: GameColor.gameMenuColor, size: CGSize(width: size.width, height: menuHeight))
        
        let gameOverMenuLayout: [[String : Any?]] = [
            ["name": "MenuButtonBG",    "frame": CGRect(x: 0, y: offsetY, width: 320, height: buttonHeight),   "title":"ButtonBG1"],
            ["name": "PlayAgain",       "frame": CGRect(x: 0, y: offsetY, width: 320, height: buttonHeight),   "title":"GMCPlayAgain"],
            
            ["name": "MenuButtonBG",    "frame": CGRect(x: 0, y: -offsetY, width: 320, height: buttonHeight),     "title":"ButtonBG2"],
            ["name": "MainMenu",        "frame": CGRect(x: 0, y: -offsetY, width: 320, height: buttonHeight),     "title":"GMCMainMenu"]
        ]
        SceneUtility.addNodes(on: gameOverMenu, from: gameOverMenuLayout)
    }
    
    func showMenu() {
        backgroundNode.addChild(gameOverMenu)
    }
    
    func hideMenu() {
        backgroundNode.removeChildren(in: [gameOverMenu])
    }
    
    func backToMenu() {
        self.view?.presentScene(global.mainMenuScene, transition: SKTransition.doorsCloseHorizontal(withDuration: 0.5))
        gameController.resetGame()
        
        hideMenu()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else {
            return
        }
        touchBeginPosition = location
        
        guard let node = self.nodes(at: location).first,
            let nodeName = node.name else {
            return
        }
        
        var shouldPlaySound = true
        if nodeName == "BackButtonNode" {
            backToMenu()
        } else if nodeName.hasSuffix("ControlButtonNode") {
            shouldPlaySound = false
            
            let isValidChange: Bool
            switch nodeName {
            case "LeftControlButtonNode":
                isValidChange = gameController.changeDirection(direction: .left)
            case "RightControlButtonNode":
                isValidChange = gameController.changeDirection(direction: .right)
            case "UpControlButtonNode":
                isValidChange = gameController.changeDirection(direction: .up)
            case "DownControlButtonNode":
                isValidChange = gameController.changeDirection(direction: .down)
            default:
                isValidChange = false
            }
            
            if isValidChange {
                Global.shared.playSound(name: "ControlClick")
            }
            
        } else if nodeName == "GMCPlayAgain" {
            gameController.playAgain()
            hideMenu()
        } else if nodeName == "GMCMainMenu" {
            backToMenu()
        } else {
            shouldPlaySound = false
        }
        
        if shouldPlaySound {
            Global.shared.playSound(name: "MenuClick")
            touchBeginPosition = nil
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let position = touch.location(in: self)
            
            if let touchBeginPosition = touchBeginPosition {
                let dx = touchBeginPosition.x - position.x
                let dy = touchBeginPosition.y - position.y
                
                var isValidChange = false
                var isValidMove = true
                if dx > Constant.dragOffset {
                    isValidChange = gameController.changeDirection(direction: .left)
                } else if dx < -Constant.dragOffset {
                   isValidChange = gameController.changeDirection(direction: .right)
                } else if dy > Constant.dragOffset {
                    isValidChange = gameController.changeDirection(direction: .down)
                } else if dy < -Constant.dragOffset {
                    isValidChange = gameController.changeDirection(direction: .up)
                } else {
                    isValidMove = false
                }
                
                if isValidMove {
                    self.touchBeginPosition = nil
                    
                    if isValidChange {
                        Global.shared.playSound(name: "ControlClick")//Pan
                    }
                }
                
            }
        }
    }
    
}

extension GameScene: GameControllerDelegate {
    func controllerDidFinishGame() {
        showMenu()
    }
}
