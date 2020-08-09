//
//  GameViewController.swift
//  Snake
//
//  Created by Shamsur Rahman on 6/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let global = Global.shared
            global.prepare()
            
            // Present the scene
            view.presentScene(global.mainMenuScene)
            
            //view.ignoresSiblingOrder = true
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
