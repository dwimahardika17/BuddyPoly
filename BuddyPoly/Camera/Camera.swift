//
//  Camera.swift
//  BuddyPoly
//
//  Created by I MADE DWI MAHARDIKA on 04/05/23.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit
import Photos
import CoreImage

struct Camera: View {
    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    @State private var image : UIImage?
    
    var body: some View {
//        NavigationView {
            ZStack(alignment: .bottom){
                ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all)
                HStack{
                    Button {
                        arViewModel.arView.snapshot(saveToHDR: false) { (image) in
                            if let image = image {
                                let filteredImage = applyFrameFilter(to: image)
                                var assetCollection = fetchAssetCollectionForAlbum(albumTitle: "Stary")
                                if let compressedImage = filteredImage?.jpegData(compressionQuality: 0.8) {
                                    // Create a new album
                                    if assetCollection == nil {
                                        PHPhotoLibrary.shared().performChanges({
                                            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: "Stary")
                                        }) { success, error in
                                            if success {
                                                // Fetch the newly created album
                                                let options = PHFetchOptions()
                                                options.predicate = NSPredicate(format: "title = %@", "Stary")
                                                let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
                                                if let album = collection.firstObject {
                                                    // Save the photo to the album
                                                    PHPhotoLibrary.shared().performChanges({
                                                        let request = PHAssetChangeRequest.creationRequestForAsset(from: UIImage(data: compressedImage)!)
                                                        let placeholder = request.placeholderForCreatedAsset
                                                        let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                                                        albumChangeRequest?.addAssets([placeholder!] as NSArray)
                                                    })
                                                }
                                            } else {
                                                print("Error creating album: \(error?.localizedDescription ?? "unknown error")")
                                            }
                                        }
                                    }
                                    
                                    if let assetCollection = assetCollection {
                                        let options = PHFetchOptions()
                                        options.predicate = NSPredicate(format: "title = %@", "Stary")
                                        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
                                        if let album = collection.firstObject {
                                            // Save the photo to the album
                                            PHPhotoLibrary.shared().performChanges({
                                                let request = PHAssetChangeRequest.creationRequestForAsset(from: UIImage(data: compressedImage)!)
                                                let placeholder = request.placeholderForCreatedAsset
                                                let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                                                albumChangeRequest?.addAssets([placeholder!] as NSArray)
                                            })
                                        }
                                    }
                                    
                                }
                            }
                        }
                        
                    } label: {
                        Image(systemName: "camera")
                            .frame(width:60, height:60)
                            .font(.title)
                            .background(.white.opacity(0.75))
                            .cornerRadius(30)
                            .padding()
                    }
                    
                    Button {
                        // CODE TO SWITCH CAMERAS
                        arViewModel.switchCamera()
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .frame(width:60, height:60)
                            .font(.title)
                            .background(.white.opacity(0.75))
                            .cornerRadius(30)
                            .padding()
                    }
                    
                }
            }
//        }
    }
    
    func applyFrameFilter(to image: UIImage) -> UIImage? {
        guard let filter = CIFilter(name: "CIOverlayBlendMode") else { return nil }
        guard let inputImage = CIImage(image: image) else { return nil }
        guard let frameImage = UIImage(named: "DisplayView-02") else { return nil } // Replace with the name of your frame image
        let overlayImage = CIImage(image: frameImage)?.transformed(by: CGAffineTransform(scaleX: inputImage.extent.width / frameImage.size.width, y: inputImage.extent.height / frameImage.size.height))
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(overlayImage, forKey: kCIInputBackgroundImageKey)
        let context = CIContext(options: nil)
        guard let outputImage = filter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    func fetchAssetCollectionForAlbum(albumTitle: String) -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumTitle)
        let assetCollection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions).firstObject
        return assetCollection
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let mission = ["mission01", "mission02", "mission03", "mission04", "mission05", "mission06", "mission07", "mission08", "mission09", "mission10"]
    
    
    var arViewModel: ARViewModel
    
    
    
    func makeUIView(context: Context) -> ARView {
        arViewModel.arView.session.run(ARFaceTrackingConfiguration())
        //      arViewModel.arView = ARView(frame: .zero)
        // Load the "Box" scene from the "Experience" Reality File
        
        let missionType = mission.randomElement()
        
//        switch missionType{
//        case "mission01":
//            let boxAnchor = try! Mission01.loadBox()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission02":
//            let boxAnchor = try! Mission02.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission03":
//            let boxAnchor = try! Mission03.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission04":
//            let boxAnchor = try! Mission04.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission05":
//            let boxAnchor = try! Mission05.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission06":
//            let boxAnchor = try! Mission06.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission07":
//            let boxAnchor = try! Mission07.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission08":
//            let boxAnchor = try! Mission08.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission09":
//            let boxAnchor = try! Mission09.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        case "mission10":
//            let boxAnchor = try! Mission10.loadSkenario()
//            // Add the box anchor to the scene
//            arViewModel.arView.scene.anchors.append(boxAnchor)
//        default:
//            break
//        }
        
        return arViewModel.arView
        
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct Camera_Previews: PreviewProvider {
    static var previews: some View {
        Camera()
    }
}
