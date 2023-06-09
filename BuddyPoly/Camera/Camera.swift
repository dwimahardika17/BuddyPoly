//
//  Camera.swift
//  BuddyPoly
//
//  Created by I MADE DWI MAHARDIKA on 04/05/23.
//

import SwiftUI
import RealityKit
import ARKit
import Photos

struct Camera : View {
    @State private var photoSaved = false
//    @EnvironmentObject var viewModel: GameViewModel
    @State private var showingAlert = false
    @State private var showHomeView = false
//    @State private var capturedImage: UIImage?
    
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainer().edgesIgnoringSafeArea(.all)
            Button {
                // Placeholder: take a snapshot
                ARVariables.arView.snapshot(saveToHDR: false) { (image) in
                    guard let image = image else {
                        return
                    }
                    
                    let imageWithFrame = addFrame(to: image)
                    
                    // Create a new PHAssetCollection (album) or retrieve an existing one
                    let albumTitle = "BuddyPoly"
                    var assetCollection: PHAssetCollection?
                    let options = PHFetchOptions()
                    options.predicate = NSPredicate(format: "title = %@", albumTitle)
                    let fetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
                    if let firstObject = fetchResult.firstObject {
                        assetCollection = firstObject
                    } else {
                        var assetCollectionPlaceholder: PHObjectPlaceholder?
                        PHPhotoLibrary.shared().performChanges({
                            let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumTitle)
                            assetCollectionPlaceholder = createAlbumRequest.placeholderForCreatedAssetCollection
                        }, completionHandler: { (success, error) in
                            if success, let placeholder = assetCollectionPlaceholder {
                                assetCollection = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [placeholder.localIdentifier], options: nil).firstObject
                            }
                        })
                    }
                    
                    // Save the image to the custom album
                    if let album = assetCollection {
                        PHPhotoLibrary.shared().performChanges({
                            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: imageWithFrame!)
                            let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
                            albumChangeRequest?.addAssets([assetChangeRequest.placeholderForCreatedAsset!] as NSFastEnumeration)
                        }, completionHandler: { (success, error) in
                            if success {
                                print("Saved to custom album")
                                self.photoSaved = true
                            } else {
                                print("Error saving to custom album: \(error?.localizedDescription ?? "Unknown error")")
                            }
                            
                        })
                    } else {
                        print("Error creating/retrieving custom album")
                    }
                }
                showingAlert = true
            } label: {
                Image(systemName: "camera")
                    .frame(width:60, height:60)
                    .font(.title)
                    .background(.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding()
            }
            }
            
        }
    
    }
func addFrame(to image: UIImage) -> UIImage? {
    let frameImage = UIImage(named: "frame")! // replace with your own frame image
    
    let size = image.size
    let frameSize = frameImage.size
    
    // Calculate the scaling factor based on the width of the image
    let scaleFactor = size.width / frameSize.width
    
    // Scale the frame size
    let scaledFrameSize = CGSize(width: frameSize.width * scaleFactor, height: frameSize.height * scaleFactor)
    
    UIGraphicsBeginImageContext(size)
    
    // Draw the original image
    image.draw(in: CGRect(origin: .zero, size: size))
    
    // Draw the scaled frame on top of the original image
    let x = (size.width - scaledFrameSize.width) / 2
    let y = (size.height - scaledFrameSize.height) / 2
    frameImage.draw(in: CGRect(origin: CGPoint(x: x, y: y), size: scaledFrameSize))
    
    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resultImage
}

//}

struct ARVariables{
    static var arView: ARView!
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let pusaka = ["majapahit", "sutasoma", "kris"]
        let arView = ARView(frame: .zero)
        
        // Create ARSession
        let arSession = ARSession()
        let arConfiguration = ARFaceTrackingConfiguration()
        arSession.run(arConfiguration, options: [])
        
        // Add ARView to ARSession
        arView.session = arSession
        
        
        ARVariables.arView = arView // Set arView to static variable for access from Camera struct
        
        let boxAnchor = try! Mission02.loadSkenario()
        arView.scene.addAnchor(boxAnchor)
        
        return arView
    }
    
    
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct Camera_Previews : PreviewProvider {
    static var previews: some View {
        Camera()
    }
}
#endif
