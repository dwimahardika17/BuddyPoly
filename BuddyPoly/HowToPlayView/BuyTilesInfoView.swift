//
//  BuyTilesInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct BuyTilesInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
                    HStack {
                        Image("buyButton")
                            .resizable()
                            .frame(width: 420, height: 120)
                            .padding(.horizontal, 50)
                        
                        Image("skipButton")
                            .resizable()
                            .frame(width: 250, height: 120)
                            .padding(.horizontal, 50)
                    }
                    
                    Text("IF YOU LAND ON \"TRUTH OR DARE\" OR \"WOULD YOU\" OR \"2 TRUTH 1 LIE\" TILE, YOU CAN BUY OR SKIP THE TILE")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        AquisitionInfoView()
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

struct BuyTilesInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BuyTilesInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
