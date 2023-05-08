//
//  StartInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct CameraInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("startCamera")
                        .resizable()
                        .frame(width: 700, height: 200)
                    
                    Text("IF PLAYER VISITS \"START\" TILE, OTHER PLAYERS WILL BE PULLED ALONG TO THE \"START\" TILE THEN ALL PLAYERS WILL HAVE TO TAKE A PICTURE TOGETHER")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        StartInfoView()
                    } label: {
                        Image("Next")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}

struct CameraInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CameraInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
