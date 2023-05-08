//
//  SafeHouseInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct SafeHouseInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("safeHouse")
                        .resizable()
                        .frame(width: 300, height: 290)
                    
                    Text("IF PLAYER VISITS \"SAFE HOUSE\" TILE, PLAYER WILL GET  10% BONUS COINS OF THEIR TOTAL COINS FROM THE SYSTEM")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        ChallengeInfoView()
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

struct SafeHouseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SafeHouseInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
