//
//  GameKitHelper.swift
//  Snake
//
//  Created by Shamsur Rahman on 9/8/20.
//  Copyright © 2020 Shamsur Rahman. All rights reserved.
//

import UIKit
import GameKit

class GameKitHelper: NSObject {
    static var shared: GameKitHelper = GameKitHelper()
    
    var isAuthenticated: Bool {GKLocalPlayer.local.isAuthenticated}
    
    var authenticationViewController: UIViewController?
    
    func authenticateLocalPlayer() {
        let player = GKLocalPlayer.local
        player.authenticateHandler = { [weak self] vc, error in
            guard let `self` = self else { return }
            if let vc = vc {
                self.authenticationViewController = vc
            }
        }
    }
    
    func showLeaderboard() {
        
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        
        if isAuthenticated {
            let vc = GKGameCenterViewController()
            vc.gameCenterDelegate = self
            vc.viewState = .leaderboards
            rootVC.present(vc, animated: true, completion: nil)
        } else if let authenticationViewController = authenticationViewController {
            rootVC.present(authenticationViewController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Game Center is not enable",
                                          message: "Game Center is not enabled for this app.",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            rootVC.present(alert, animated: true)
        }
    }
    
    func reportHighScore(score: Int64) {
        guard isAuthenticated else {
            print("Game Center is not enabled for this app.")
            return
        }
        
        // Use the leaderboard identifier created in app store connect
        let leaderboardID = "shamsur.rahman.snake.highscore"
        let reportedScore = GKScore(leaderboardIdentifier: leaderboardID)
        reportedScore.value = score
        GKScore.report([reportedScore]) { (error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            print("The score submitted to the game center")
        }
    }
}

extension GameKitHelper: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
