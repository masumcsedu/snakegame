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
            
            /// Initialize game & set up UserDefaults with Global
            let global = Global.shared
            
            /// Creates game scenes
            global.prepare()
            
            /// Present the scene
            view.presentScene(global.mainMenuScene)
            
            /// Uncomment following code to see game rendering performance
            //view.ignoresSiblingOrder = true
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
