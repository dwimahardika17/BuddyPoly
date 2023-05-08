//
//  LetGoInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct LetGoInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("cryingGiraffe")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                    Text("IF PLAYER VISITS \"LET GO\" TILE, PLAYER WILL HAVE TO GIVE 10% OF THEIR TOTAL COINS TO THE SYSTEM")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        CameraInfoView()
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

struct LetGoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LetGoInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
