//
//  EndGameInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct EndGameInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("cryingChic")
                        .resizable()
                        .frame(width: 270, height: 300)
                    
                    Text("THE GAME WILL ANE IF ONE OF THE PLAYER HAS LESS THAN 0 COIN")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        OutroView()
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

struct EndGameInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
