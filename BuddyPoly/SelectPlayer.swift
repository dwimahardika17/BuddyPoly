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
    //    @State private var playerNames = "Dika"
    @State private var playerNames = Array(repeating: "", count: 4)
    @State private var isHidden = false
    @State private var opc = 1.0
    @State private var showGameView = false
    @State private var slider = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        HStack{
            VStack{
                Text("PLAYER COUNT")
                    .font(.largeTitle)
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
            .navigationBarTitle("My View")
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
                VStack{
                    Text("PLAYER NAME")
                        .font(.largeTitle)
                    //                    HStack{
                    //                        Image("Oval")
                    //                            .resizable()
                    //                            .frame(width: 50, height: 50)
                    //                        Image("Oval")
                    //                            .resizable()
                    //                            .frame(width: 50, height: 50)
                    //                        Image("Oval")
                    //                            .resizable()
                    //                            .frame(width: 50, height: 50)
                    //                        Image("Oval")
                    //                            .resizable()
                    //                            .frame(width: 50, height: 50)
                    //                    }
                    ForEach(0..<Int(playerCount), id: \.self) { index in
                        TextField("Player \(index + 1)", text: $playerNames[index])
                            .background()
                            .frame(width: 300)
                            .cornerRadius(10)
                    }
                        Image("Start")
                            .resizable()
                            .frame(width: 100, height: 50)
                            .onTapGesture {
                                var playersData = Array(repeating: PlayersData(playersName: "", currentSteps: 0, currentPoin: 750, pieceNode: SKSpriteNode()), count: Int(playerCount))
                                for index in 0..<Int(playerCount) {
                                    playersData[index].playersName = playerNames[index]
                                }
                                showGameView = true
                            }
                    NavigationLink(destination: Game(), isActive: $showGameView) {
                               EmptyView()
                           }
                    
                        
                    //            .hidden()
                }
                .frame(width: 500, height: 500)
                .background(.white)
                .cornerRadius(20)
                .offset(x:-30)
            }
                
                
            }
                .background(Image("background1"))
            
        }
    }

//func addPlayer(name: String, steps: Int, poin: Int) {
//    let newPlayerData = playersData(playersName: name, currentSteps: steps, currentPoin: poin)
//    playersDataArray.append(newPlayerData)
//}
    
    struct SelectPlayer_Previews: PreviewProvider {
        static var previews: some View {
            SelectPlayer()
        }
    }
