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
               
                Image("logo")
                    .resizable()
//                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .frame(width: 300, height: 300)

                    
                NavigationLink(destination: SelectPlayer()){
                        Image("Play")
                        .resizable()
                        .offset(y:60)
                        .frame(width: 370, height: 150)
                        
                    }
                NavigationLink(destination: SelectPlayer()){
                        Image("HowToPlay")
                        .resizable()
                        .frame(width: 370, height: 100)
                        .offset(y:80)
                        
                    }
                
                    
            }
            .frame(width: 10000, height: 1000)
            .background(Image("background1")
                .resizable()
                .scaledToFit())
        .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
