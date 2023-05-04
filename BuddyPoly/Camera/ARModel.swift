//
//  ARView.swift
//  BuddyPoly
//
//  Created by I MADE DWI MAHARDIKA on 04/05/23.
//

import Foundation
import RealityKit
import ARKit

struct ARModel {
    private(set) var arView : ARView
    
    
    init() {
        arView = ARView(frame: .zero)
    }
    
    func switchCamera() {
            guard var newConfig = arView.session.configuration else {
                fatalError("Unexpectedly failed to get the configuration.")
            }
            switch newConfig {
            case is ARWorldTrackingConfiguration:
                newConfig = ARFaceTrackingConfiguration()
            case is ARFaceTrackingConfiguration:
                newConfig = ARWorldTrackingConfiguration()
                
            default:
                // In this tutorial, we are only working with ARWorldTrackingConfiguration and ARFaceTrackingConfiguration
                newConfig = ARWorldTrackingConfiguration()
            }
            
            arView.session.run(newConfig)
        }
}
