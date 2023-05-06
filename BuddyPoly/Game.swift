//
//  Game.swift
//  BuddyPoly
//
//  Created by I MADE DWI MAHARDIKA on 02/05/23.
//

import SwiftUI
import SpriteKit

struct Game: View {
    var scene: SKScene {
            let scene = GameScene()
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5) // Set the anchor point to the center of the scene
            scene.size = CGSize(width: 100, height: 100)
            scene.scaleMode = .resizeFill
            return scene
        }

        var body: some View {
            SpriteView(scene: self.scene)
                .frame(width: 1200, height: 900)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        }
    
}


struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
