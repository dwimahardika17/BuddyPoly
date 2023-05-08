//
//  StartInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct StartInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("startCoin")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                    Text("PLAYER WILL GET 150 BONUS COINS EVERYTIME THEY PASSES THE \"START\" TILE")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        EndGameInfoView()
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

struct StartInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StartInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
