//
//  SwiftUIView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background1")
                
                Rectangle()
                    .frame(width: 700, height: 500)
                    .cornerRadius(80)
                    .foregroundColor(.white)
                    .shadow(radius: 20)
                    .opacity(0.5)
                
                VStack {
                    Text("HOW TO PLAY BUDDYPOLY")
                        .font(.system(size: 70, weight: .black, design: .rounded))
                        .multilineTextAlignment(.center)
                        .kerning(4)
                        .foregroundColor(Color("darkBlue"))
                        .padding(.horizontal, 270)
                    
                    NavigationLink {
                        PlayerInstructionView()
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

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView().previewInterfaceOrientation(.landscapeLeft)
    }
}
