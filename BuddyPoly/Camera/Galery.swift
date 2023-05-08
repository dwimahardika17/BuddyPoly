//
//  Galery.swift
//  Sakara
//
//  Created by I MADE DWI MAHARDIKA on 15/04/23.
//

import SwiftUI
import Photos



struct Galery: View {
    
    @State private var images: [UIImage] = []
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                if images.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                            ForEach(images, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                        }
                    }
                } else {
                    Text("No images found in the custom album")
                }
            }
            .position(x:reader.frame(in: .global).width * 1/2, y:reader.frame(in: .global).height * 1/2)
            .background(Image("background1")
                .resizable()
                .frame(width: reader.frame(in: .global).maxX, height: reader.frame(in: .global).maxY*1.1)
                .ignoresSafeArea())
            .onAppear {
                fetchImagesFromCustomAlbum()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image("back")
//                    Text("Back")
                }
            }
            )
        }
//        .ignoresSafeArea()
        }

        func fetchImagesFromCustomAlbum() {
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "title = %@", "Sakara")
            let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: options)

            if let album = albums.firstObject {
                let assets = PHAsset.fetchAssets(in: album, options: nil)

                assets.enumerateObjects { asset, _, _ in
                    let requestOptions = PHImageRequestOptions()
                    requestOptions.isSynchronous = true
                    requestOptions.deliveryMode = .highQualityFormat

                    PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: requestOptions) { image, _ in
                        if let image = image {
                            self.images.append(image)
                        }
                    }
                }
            }
        }
}

struct Galery_Previews: PreviewProvider {
    static var previews: some View {
        Galery()
    }
}
