//
//  PlayersAndCardInitiation.swift
//  TestSprite
//
//  Created by Indah Rahmawati on 27/04/23.
//

import Foundation
import SpriteKit

struct Card: Identifiable {
    let id = UUID()
    let cardNumber: Int
    var cardOwner: String
    var cardChallengesType: String
    var cardChallenge: String
    var firstPrompt: String
    var secondPrompt: String
    var thirdPrompt: String
    var correctPrompt: String
    
    init(cardNumber: Int, cardOwner: String, cardChallengesType: String, cardChallenge: String, firstPrompt: String, secondPrompt: String, thirdPrompt: String, correctPrompt: String) {
        self.cardNumber = cardNumber
        self.cardOwner = cardOwner
        self.cardChallengesType = cardChallengesType
        self.cardChallenge = cardChallenge
        self.firstPrompt = firstPrompt
        self.secondPrompt = secondPrompt
        self.thirdPrompt = thirdPrompt
        self.correctPrompt = correctPrompt
    }
}

extension Card {
    static var cardData: [Card] {
        [
            Card(cardNumber: 0, cardOwner: "Null", cardChallengesType: "Start", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 1, cardOwner: "Null", cardChallengesType: "Safe House", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 2, cardOwner: "Null", cardChallengesType: "Would You Rather", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 3, cardOwner: "Null", cardChallengesType: "Challenge", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 4, cardOwner: "Null", cardChallengesType: "2 Truth 1 Lie", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 5, cardOwner: "Null", cardChallengesType: "Would You Rather", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 6, cardOwner: "Null", cardChallengesType: "Truth or Dare", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 7, cardOwner: "Null", cardChallengesType: "Challenge", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 8, cardOwner: "Null", cardChallengesType: "2 Truth 1 Lie", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 9, cardOwner: "Null", cardChallengesType: "Truth or Dare", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 10, cardOwner: "Null", cardChallengesType: "Would You Rather", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 11, cardOwner: "Null", cardChallengesType: "Challenge", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 12, cardOwner: "Null", cardChallengesType: "Would You Rather", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 13, cardOwner: "Null", cardChallengesType: "Truth or Dare", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 14, cardOwner: "Null", cardChallengesType: "Truth or Dare", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 15, cardOwner: "Null", cardChallengesType: "Challenge", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 16, cardOwner: "Null", cardChallengesType: "Force Move", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 17, cardOwner: "Null", cardChallengesType: "2 Truth 1 Lie", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 18, cardOwner: "Null", cardChallengesType: "2 Truth 1 Lie", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 19, cardOwner: "Null", cardChallengesType: "Challenge", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 20, cardOwner: "Null", cardChallengesType: "Would You Rather", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 21, cardOwner: "Null", cardChallengesType: "2 Truth 1 Lie", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 22, cardOwner: "Null", cardChallengesType: "Truth or Dare", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 23, cardOwner: "Null", cardChallengesType: "Challenge", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
            Card(cardNumber: 24, cardOwner: "Null", cardChallengesType: "LG", cardChallenge: "Null", firstPrompt: "", secondPrompt: "", thirdPrompt: "", correctPrompt: ""),
        ]
    }
}

struct PlayersData: Identifiable {
    let id = UUID()
    var playersName: String
    var currentSteps: Int
    var currentPoin: Int
    var pieceNode: SKSpriteNode
    
    init(playersName: String, currentSteps: Int, currentPoin: Int, pieceNode: SKSpriteNode) {
        self.playersName = playersName
        self.currentSteps = currentSteps
        self.currentPoin = currentPoin
        self.pieceNode = pieceNode
        self.pieceNode.size = CGSize(width: 100, height: 100)
    }
}

extension PlayersData {
    static var sampleData: [PlayersData] {
        [
            
        ]
    }
}

func addPlayer(name: String, steps: Int, poin: Int, pieceNode: SKSpriteNode) {
    let newPlayerData = PlayersData(playersName: name, currentSteps: steps, currentPoin: poin, pieceNode: pieceNode)
    playersDataArray.append(newPlayerData)
}
var cardArray = Card.cardData // inisiasi array
var playersDataArray = PlayersData.sampleData // inisiasi array


