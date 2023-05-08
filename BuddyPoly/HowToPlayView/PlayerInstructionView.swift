//
//  PlayerInstructionView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct PlayerInstructionView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    HStack {
                        Image("playerfix1")
                            .resizable()
                            .frame(width: 130, height: 150)
                            .shadow(radius: 15)
                            .padding()
                        Image("playerfix2")
                            .resizable()
                            .frame(width: 160, height: 150)
                            .shadow(radius: 15)
                            .padding()
                        Image("playerfix3")
                            .resizable()
                            .frame(width: 160, height: 150)
                            .shadow(radius: 15)
                            .padding()
                        Image("playerfix4")
                            .resizable()
                            .frame(width: 130, height: 150)
                            .shadow(radius: 15)
                            .padding()
                    }
                    
                    Text("PLAY WITH YOUR FRIENDS UP TO 4 PEOPLE")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        CoinInstructionView()
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

struct PlayerInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInstructionView().previewInterfaceOrientation(.landscapeLeft)
    }
}
