//
//  ContentView.swift
//  BuddyPoly
//
//  Created by I MADE DWI MAHARDIKA on 02/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
               
                Image("Logo 1")
                    .resizable()
//                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .frame(width: 300, height: 300)

                    
                NavigationLink(destination: SelectPlayer()){
                        Image("Play")
                        .resizable()
                        .frame(width: 370, height: 150)
                        
                    }
                NavigationLink(destination: IntroView()){
                        Image("HowToPlay")
                        .resizable()
                        .frame(width: 370, height: 100)
                        
                    }
                NavigationLink(destination: Galery()){
                        Image("Galery")
                        .resizable()
                        .frame(width: 370, height: 100)
                        
                    }
                
                    
            }
            .frame(width: 10000, height: 1000)
            .background(Image("background1")
                .resizable()
                .scaledToFit())
        .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
