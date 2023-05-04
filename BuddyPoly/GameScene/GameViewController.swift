//
//  GameViewController.swift
//  TestSprite
//
//  Created by I MADE DWI MAHARDIKA on 21/04/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

            // Create a new UIView for the player info

//            playerInfoView2.translatesAutoresizingMaskIntoConstraints = false
//            playerInfoView2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//            playerInfoView2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
//
//            playerInfoView3.translatesAutoresizingMaskIntoConstraints = false
//            playerInfoView3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//            playerInfoView3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//
//            playerInfoView4.translatesAutoresizingMaskIntoConstraints = false
//            playerInfoView4.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//            playerInfoView4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//
//            if let gameScene = view.scene as? GameScene {
//                if let playerInfoView1 = view.subviews.first(where: { $0 is UIView }) {
//                    if let scoreLabel1 = playerInfoView1.subviews.first(where: { $0 is UILabel }) as? UILabel {
//                        scoreLabel1.text = "\(playersDataArray[0].currentPoin)"
//                    }
//                }
//            }
            
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
