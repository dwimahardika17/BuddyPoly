//
//  ARViewModel.swift
//  BuddyPoly
//
//  Created by I MADE DWI MAHARDIKA on 04/05/23.
//

import Foundation
import RealityKit

class ARViewModel: ObservableObject {
    @Published private var model : ARModel = ARModel()
    
    var arView : ARView {
        model.arView
    }
    
    func switchCamera() {
        model.switchCamera()
    }
}
