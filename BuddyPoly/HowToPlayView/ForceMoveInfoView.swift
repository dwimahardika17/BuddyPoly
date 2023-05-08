//
//  ForceMoveInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct ForceMoveInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("forceMove")
                        .resizable()
                        .frame(width: 380, height: 200)
                    
                    Text("IF PLAYER VISITS \"FORCE MOVE\" TILE, RANDOM PLAYER WILL BE MOVED TO RANDOM TILE")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        LetGoInfoView()
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

struct ForceMoveInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ForceMoveInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
