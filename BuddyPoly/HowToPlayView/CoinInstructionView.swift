//
//  CoinInstructionView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct CoinInstructionView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("coin 1")
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    Text("EACH PLAYER GETS INITIAL 750 COINS")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        BoardInfoView()
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

struct CoinInstructionView_Previews: PreviewProvider {
    static var previews: some View {
        CoinInstructionView().previewInterfaceOrientation(.landscapeLeft)
    }
}
