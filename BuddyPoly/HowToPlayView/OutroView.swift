//
//  OutroView.swift
//  BuddyPoly
//
//  Created by Intan Saliya Utomo on 07/05/23.
//

import SwiftUI

struct OutroView: View {
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
                    Text("HAVE FUN!")
                        .font(.system(size: 70, weight: .black, design: .rounded))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("darkBlue"))
                        .kerning(4)
                        .padding(.horizontal, 270)
                    
                    NavigationLink {
                        ContentView()
                    } label: {
                        Image("Start")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden(true)
    }
}

struct OutroView_Previews: PreviewProvider {
    static var previews: some View {
        OutroView().previewInterfaceOrientation(.landscapeLeft)
    }
}
