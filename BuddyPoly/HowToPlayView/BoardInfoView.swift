//
//  BoardInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct BoardInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    Image("board")
                        .resizable()
                        .frame(width: 600, height: 350)
                    
                    Text("THERE ARE 8 DIFFERENT TYPE OF TILES")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 230)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        BuyTilesInfoView()
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

struct BoardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BoardInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
