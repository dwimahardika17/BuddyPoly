//
//  GameView.swift
//  BuddyPoly
//
//  Created by I MADE DWI MAHARDIKA on 03/05/23.
//

import Foundation
import SwiftUI
import SpriteKit

struct GameView: UIViewRepresentable {
    typealias UIViewType = SKView
    
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        view.presentScene(scene)
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        // No updates needed for this view
    }
}

