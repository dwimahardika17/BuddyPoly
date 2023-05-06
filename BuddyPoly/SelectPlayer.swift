//
//  SelectPlayer.swift
//  BuddyPoly
//
//  Created by I MADE DWI MAHARDIKA on 02/05/23.
//

import SwiftUI
import SpriteKit

struct SelectPlayer: View {
    @State private var playerCount = 2.0
    @State private var counter = 0
        @State private var playerNames1 = "Dika"
    @State private var playerNames = Array(repeating: "", count: 4)
    @State private var isHidden = false
    @State private var isHidden1 = false
    @State private var isHidden2 = false
    @State private var opc = 1.0
    @State private var showGameView = false
    @State private var slider = false
    @State private var currentPlayerIndex = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack{
            VStack{
                Text("PLAYER COUNT")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Text("\(Int(playerCount))")
                    .font(.title)
                Slider(value: $playerCount, in: 2...4)
                    .frame(width: 350)
                    .disabled(slider)
                Button(action: {
                    isHidden.toggle()
                    slider.toggle()
                    opc = 0.5
                }) {
                    Image("Next")
                        .resizable()
                        .frame(width: 100, height: 50)
                }
                .disabled(slider)
            }
            .frame(width: 500, height: 500)
            .background(.white)
            .opacity(opc)
            .cornerRadius(20)
//            .navigationBarTitle("My View")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image("back")
//                    Text("Back")
                }
            }
            )
            if isHidden {
                VStack {
                    Text("PLAYER NAME")
                        .font(.largeTitle)
                    
                    ScrollView {
                        ForEach(0..<Int(playerCount), id: \.self) { index in
                            ZStack() {
                                Rectangle()
                                    .frame(width: 300, height: 100)
                                    .cornerRadius(25)
                                    .foregroundColor(.green)
                                    .opacity(0.3)
                                    .shadow(radius: 5)
                                    .padding(.bottom, 10)
                                VStack() {
                                    Image("playerfix\(index+1)")
                                    TextField("Player \(index + 1)", text: $playerNames[index])
                                        .frame(minWidth: 100)
                                        .cornerRadius(10)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    Image("Start")
                        .resizable()
                        .frame(width: 100, height: 50)
                        .onTapGesture {
                            
                            for index in 0..<Int(playerCount) {
                                addPlayer(name: playerNames[index], steps: 0, poin: 750, pieceNode: SKSpriteNode(imageNamed: "playerfix\(index+1)"))
                                
                                
                            }
                            print("\(playersDataArray)")
                            showGameView = true
                        }
                    NavigationLink(destination: Game(), isActive: $showGameView) {
                        EmptyView()
                    }
                    
                    
                    //            .hidden()
                }
                    .frame(width: 500, height: 400)
                    .background(.white)
                    .cornerRadius(20)
//                .offset(x:-30)
//                }
//                ForEach(0..<Int(playerCount), id: \.self) { index in
//                    if currentPlayerIndex < Int(playerCount) {
////                        PlayerCount(index: currentPlayerIndex)
////                        currentPlayerIndex+=1
//                        PlayerCount(index: 0)
//                    }
//            VStack{
//                Text("PLAYER")
//                Image("playerfix\(index+1)")
//                TextField("player", text: $playerNames1)
//                Button(action: {
//
////                    isHidden.toggle()
//                    slider.toggle()
//                    opc = 0.5
//                }) {
//                    Image("Next")
//                        .resizable()
//                        .frame(width: 100, height: 50)
//                }
//
//            }
//            .frame(width: 500, height: 500)
//            .background(.white)
//            .cornerRadius(20)
                }
//            }
                
                
            }
                .background(Image("background1"))
            
        }
    
    func PlayerCount(index: Int) {
        VStack{
            Text("PLAYER")
            Image("playerfix\(index+1)")
            TextField("player", text: $playerNames1)
            Button(action: {
                
//                    isHidden.toggle()
                slider.toggle()
                opc = 0.5
            }) {
                Image("Next")
                    .resizable()
                    .frame(width: 100, height: 50)
            }
            
        }
        .frame(width: 500, height: 500)
        .background(.white)
        .cornerRadius(20)
    }
    }


    
    struct SelectPlayer_Previews: PreviewProvider {
        static var previews: some View {
            SelectPlayer().previewInterfaceOrientation(.landscapeLeft)
        }
    }
