//
//  ChallengeInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct ChallengeInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("challenge")
                        .resizable()
                        .frame(width: 300, height: 310)
                    
                    Text("IF PLAYER VISITS \"?\" TILE, PLAYER WILL HAVE TO ANSWER ONE RANDOM GIVEN QUESTION THEN EARN 50 COINS IF SUCCEEDED")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        ForceMoveInfoView()
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

struct ChallengeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
