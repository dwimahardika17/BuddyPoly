//
//  AquisitionInfoView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct AquisitionInfoView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                VStack {
//                    ZStack {
//                        Rectangle()
//                            .frame(width: 700, height: 300)
//                            .cornerRadius(60)
//                            .foregroundColor(.white)
//                            .opacity(0.5)
//                            .shadow(radius: 10)
//
//                        VStack {
//                            Text("DO YOU WANT TO AQUIRE?")
//                                .font(.system(size: 50, weight: .black, design: .rounded))
//                                .foregroundColor(.black)
//                                .multilineTextAlignment(.center)
//                                .kerning(4)
//                                .padding(.horizontal, 200)
//                                .padding(.vertical, 20)
//
//                            HStack {
//                                Image("buyButton")
//                                    .resizable()
//                                    .frame(width: 300, height: 90)
//                                    .padding(.horizontal, 20)
//
//                                Image("skipButton")
//                                    .resizable()
//                                    .frame(width: 190, height: 90)
//                                    .padding(.horizontal, 20)
//                            }
//                        }
//                    }
                    Image("acquisitionPopUp")
                        .resizable()
                        .frame(width: 500, height: 250)
                    
                    Text("IF PLAYER SUCCEEDED THE GIVEN CHALENGE, PLAYER CAN ACQUIRE OTHER PLAYER'S TILE OR SKIP THE TILE")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 50)
                    
                    NavigationLink {
                        SafeHouseInfoView()
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

struct AquisitionInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AquisitionInfoView().previewInterfaceOrientation(.landscapeLeft)
    }
}
