//
//  GameScene.swift
//  TestSprite
//
//  YANG INDAH
//

import SpriteKit
import GameplayKit
import SwiftUI
import Dispatch
import UIKit

//var cardArray = Card.cardData // inisiasi array
//var playersDataArray = PlayersData.sampleData // inisiasi array
var buy : Bool = true
var challenges = Challenge.allValues // inisiasi challenge

class MyObject {
    var objPosition: CGPoint = .zero
    
    func setPosition(position: CGPoint) {
        objPosition = position
    }
}

class Player {
    var name: String
    var pieceNode: SKSpriteNode
    var currentTileIndex: Int
    var currentPoin: Int
    
    init(name: String, pieceNode: SKSpriteNode, currentTileIndex: Int, currentPoin: Int) {
        self.name = name
        self.pieceNode = pieceNode
        self.currentTileIndex = currentTileIndex
        self.currentPoin = currentPoin
    }
}

class GameScene: SKScene {
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var boardNodes = [SKNode]()
    private var pathNodes = [CGPoint]()
    private var diceButton: SKSpriteNode?
    private var testDiceButton: SKSpriteNode?
    private var pieceNode: SKSpriteNode?
    public var diceNumber: Int = 1
    public var diceNumberFix: Int = 1
    public var coin: Int = 750
    
    //    public var players = [Player]()
    public var currentPlayerIndex = 0
    private var skip = 5
    public var skipCount = 2
    
    // NEW
    private var popUpContainer: SKSpriteNode?
    
    private var buttonLabel: SKLabelNode?
    private var buttonFrame: SKShapeNode?
    private var skipButtonLabel: SKLabelNode?
    private var skipButtonFrame: SKShapeNode?
    private var buyButtonLabel: SKLabelNode?
    private var buyButtonFrame: SKShapeNode?
    private var truthButtonLabel: SKLabelNode?
    private var truthButtonFrame: SKShapeNode?
    private var dareButtonLabel: SKLabelNode?
    private var dareButtonFrame: SKShapeNode?
    
    private var skView: SKView?
    
    let myObject = MyObject()
    private var countShown = 0
    private var buy = false
    private var userInfo: [String: Any]?
    private var userInfoBackup: [String: Any]?
    private var move: Int = 0
    
    private var textField: UITextField?
    private var textField2: UITextField?
    private var textField3: UITextField?
    
    //circles
    private var circleNode: SKShapeNode?
    private var circleNode2: SKShapeNode?
    private var circleNode3: SKShapeNode?
    private var circleNode4: SKShapeNode?
    private var circleNode5: SKShapeNode?
    
    private var firstCircleClicked = false
    private var secondCircleClicked = false
    private var thirdCircleClicked = false
    private var fourthCircleClicked = false
    private var fifthCircleClicked = false
    
    private var lieLabel: SKLabelNode?
    private var checkListLabel: SKLabelNode?
    private var selectedPrompt: String = "firstPrompt"
    
    private var challengeName: String = "Truth or Dare"
    
    private var textLabel: UILabel?
    private var textLabel2: UILabel?
    private var textLabel3: UILabel?
    
    var playerCoin1 = SKLabelNode()
    var playerCoin2 = SKLabelNode()
    var playerCoin3 = SKLabelNode()
    var playerCoin4 = SKLabelNode()
    var playerInfoBgTexture1 = SKSpriteNode()
    var playerInfoBgTexture2 = SKSpriteNode()
    var playerInfoBgTexture3 = SKSpriteNode()
    var playerInfoBgTexture4 = SKSpriteNode()
    
    
//    var jumlahPemain = 2
    
    
    
    
    private var playerInfoFrame1: SKShapeNode?
//    private var currentCoin1: SKLabelNode?
//    var currentCoin1 = SKLabelNode()
    var currentCoin1 = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
//    var playerCoinTextArray = [self.playerCoin1,self.playerCoin2,self.playerCoin3,self.playerCoin4]
    var playerCoinTextArray = [SKLabelNode]()
    var playerBgArray = [SKSpriteNode]()
//    var playerBgArray = [self.playerInfoBgTexture1,self.playerInfoBgTexture2,self.playerInfoBgTexture3,self.playerInfoBgTexture4]
    
    
    var returnAnswer = true
    
    
    override func didMove(to view: SKView) {
//        current state player 1
        
        playerInfoBgTexture1 = SKSpriteNode(imageNamed: "background_player_info_selected")
        playerInfoBgTexture1.position = CGPoint(x: -(view.bounds.size.width/2)+100, y: view.bounds.size.height/2 - 30 )
        playerInfoBgTexture1.zPosition = -50
        playerInfoBgTexture1.size = CGSize(width: 348, height: 150)
        addChild(playerInfoBgTexture1)
        
        
        let playerInfoAva1 = SKSpriteNode(imageNamed: "playerfix1")
        playerInfoAva1.position = CGPoint(x: -(view.bounds.size.width/2)-10, y: view.bounds.size.height/2 - 30)
        playerInfoAva1.size = CGSize(width: 82, height: 97)
        addChild(playerInfoAva1)
        
        let coin1 = SKSpriteNode(imageNamed: "coin")
        coin1.position = CGPoint(x: -(view.bounds.size.width/2)+80, y: view.bounds.size.height/2 - 50 )
        coin1.size = CGSize(width: 51, height: 46)
        addChild(coin1)
        
        let playerName1 = SKLabelNode()
        playerName1.position = CGPoint(x: -(view.bounds.size.width/2)+120, y: view.bounds.size.height/2 - 10)
        playerName1.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerName1.fontName = "AvenirNext-Bold"
        playerName1.text = "PLAYER 1"
        playerInfoBgTexture1.zPosition = -3
        addChild(playerName1)
        
        playerCoin1.position = CGPoint(x: -(view.bounds.size.width/2)+150, y: view.bounds.size.height/2 - 65)
        playerCoin1.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerCoin1.fontName = "AvenirNext-Bold"
        playerCoin1.text = "\(playersDataArray[0].currentPoin)"
        addChild(playerCoin1)
//        current state player 2
        
        playerInfoBgTexture2 = SKSpriteNode(imageNamed: "background_player_info")
        playerInfoBgTexture2.position = CGPoint(x: (view.bounds.size.width/2)+100-200, y: view.bounds.size.height/2 - 30 )
        playerInfoBgTexture2.size = CGSize(width: 348, height: 150)
        playerInfoBgTexture2.zPosition = -1
        addChild(playerInfoBgTexture2)
        
        let playerInfoAva2 = SKSpriteNode(imageNamed: "playerfix2")
        playerInfoAva2.position = CGPoint(x: (view.bounds.size.width/2)-10-200, y: view.bounds.size.height/2 - 30)
        playerInfoAva2.size = CGSize(width: 82, height: 97)
        addChild(playerInfoAva2)
        
        let coin2 = SKSpriteNode(imageNamed: "coin")
        coin2.position = CGPoint(x: (view.bounds.size.width/2)+80-200, y: view.bounds.size.height/2 - 50 )
        coin2.size = CGSize(width: 51, height: 46)
        addChild(coin2)
        
        let playerName2 = SKLabelNode()
        playerName2.position = CGPoint(x: (view.bounds.size.width/2)+120-200, y: view.bounds.size.height/2 - 10)
        playerName2.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerName2.fontName = "AvenirNext-Bold"
        playerName2.text = "PLAYER 2"
        addChild(playerName2)
        
        playerCoin2.position = CGPoint(x: (view.bounds.size.width/2)+150-200, y: view.bounds.size.height/2 - 65)
        playerCoin2.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerCoin2.text = "\(playersDataArray[1].currentPoin)"
        playerCoin2.fontName = "AvenirNext-Bold"
        addChild(playerCoin2)
        
//        current state 3
        
        playerInfoBgTexture3 = SKSpriteNode(imageNamed: "background_player_info")
        playerInfoBgTexture3.position = CGPoint(x: (view.bounds.size.width/2)+100-200, y: -(view.bounds.size.height/2 - 30 ))
        playerInfoBgTexture3.zPosition = -2
        playerInfoBgTexture3.size = CGSize(width: 348, height: 150)
//        addChild(playerInfoBgTexture3)
        
        let playerInfoAva3 = SKSpriteNode(imageNamed: "playerfix3")
        playerInfoAva3.position = CGPoint(x: (view.bounds.size.width/2)-10-200, y: -(view.bounds.size.height/2 - 30))
        playerInfoAva3.size = CGSize(width: 82, height: 97)
//        addChild(playerInfoAva3)
        
        let coin3 = SKSpriteNode(imageNamed: "coin")
        coin3.position = CGPoint(x: (view.bounds.size.width/2)+80-200, y: -(view.bounds.size.height/2 - 10 ))
        coin3.size = CGSize(width: 51, height: 46)
//        addChild(coin3)
        
        let playerName3 = SKLabelNode()
        playerName3.position = CGPoint(x: (view.bounds.size.width/2)+120-200, y: -(view.bounds.size.height/2 - 40))
        playerName3.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerName3.fontName = "AvenirNext-Bold"
        playerName3.text = "PLAYER 3"
//        addChild(playerName3)
        
        playerCoin3.position = CGPoint(x: (view.bounds.size.width/2)+150-200, y: -(view.bounds.size.height/2+5))
        playerCoin3.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        
        playerCoin3.fontName = "AvenirNext-Bold"
//        addChild(playerCoin3)
        
//        current player4 initiation
        
//        playerInfoBgTexture4 = SKTexture(imageNamed: "background_player_info")

        playerInfoBgTexture4 = SKSpriteNode(imageNamed: "background_player_info")
        playerInfoBgTexture4.position = CGPoint(x: -(view.bounds.size.width/2)+100, y: -(view.bounds.size.height/2-30))
        playerInfoBgTexture4.zPosition = -10
        playerInfoBgTexture4.size = CGSize(width: 348, height: 150)
//        addChild(playerInfoBgTexture4)
        
        let playerInfoAva4 = SKSpriteNode(imageNamed: "playerfix4")
        playerInfoAva4.position = CGPoint(x: -((view.bounds.size.width/2)+10), y: -(view.bounds.size.height/2 - 30))
        playerInfoAva4.size = CGSize(width: 82, height: 97)
//        addChild(playerInfoAva4)
        
        let coin4 = SKSpriteNode(imageNamed: "coin")
        coin4.position = CGPoint(x: -((view.bounds.size.width/2)+80-170), y: -(view.bounds.size.height/2 - 10 ))
        coin4.size = CGSize(width: 51, height: 46)
//        addChild(coin4)
        
        let playerName4 = SKLabelNode()
        playerName4.position = CGPoint(x: -((view.bounds.size.width/2)-130), y: -(view.bounds.size.height/2 - 40))
        playerName4.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerName4.text = "PLAYER 4"
        playerName4.fontName = "AvenirNext-Bold"
//        addChild(playerName4)
        
        playerCoin4.position = CGPoint(x: -((view.bounds.size.width/2)-160), y: -(view.bounds.size.height/2+5))
        playerCoin4.fontName = "AvenirNext-Bold"
        playerCoin4.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        
//        addChild(playerCoin4)
        
        
        playerCoinTextArray.append(playerCoin1)
        playerCoinTextArray.append(playerCoin2)
        playerBgArray.append(playerInfoBgTexture1)
        playerBgArray.append(playerInfoBgTexture2)
//        playerCoinTextArray.append(playerCoin3)
//        playerCoinTextArray.append(playerCoin4)
        
        
        if playersDataArray.count == 4 {
            playerCoinTextArray.append(playerCoin3)
            playerCoinTextArray.append(playerCoin4)
            playerBgArray.append(playerInfoBgTexture3)
            playerBgArray.append(playerInfoBgTexture4)
            addChild(playerCoin4)
            addChild(playerName4)
            addChild(coin4)
            addChild(playerInfoAva4)
            addChild(playerInfoBgTexture4)
            addChild(playerCoin3)
            addChild(playerName3)
            addChild(coin3)
            addChild(playerInfoAva3)
            addChild(playerInfoBgTexture3)
            playerCoin4.text = "\(playersDataArray[3].currentPoin)"
            playerCoin3.text = "\(playersDataArray[2].currentPoin)"
        }
        else if playersDataArray.count == 3 {
            playerCoinTextArray.append(playerCoin3)
            playerBgArray.append(playerInfoBgTexture3)
            addChild(playerCoin3)
            addChild(playerName3)
            addChild(coin3)
            addChild(playerInfoAva3)
            addChild(playerInfoBgTexture3)
            playerCoin3.text = "\(playersDataArray[2].currentPoin)"
        }
        

        
        //-----------------------------------BACKGROUND INITIATION--------------------------------------
        let background = SKSpriteNode(imageNamed: "mini2")
        background.position = CGPoint(x: 0, y: 0)
        background.size = self.size
        background.zPosition = -200
        addChild(background)
        
        
        
        let boardNode = SKNode()
        addChild(boardNode)
        
        let tileWidth: CGFloat = 50
        let tileHeight: CGFloat = 50
        let transparant = UIColor.red.withAlphaComponent(0)
        
        //------------------------------------BOARD CARD INITIATION--------------------------------------
        for _ in 0..<25 {
            let tileNode = SKSpriteNode(color: transparant, size: CGSize(width: tileWidth, height: tileHeight))
            boardNode.addChild(tileNode)
            boardNodes.append(tileNode)
        }
        
        boardNodes[0].position = CGPoint(x: 130 , y: -10) //START
        boardNodes[1].position = CGPoint(x: 190 , y: -110) //HOME
        boardNodes[2].position = CGPoint(x: 280 , y: -170) //WY
        boardNodes[3].position = CGPoint(x: 380 , y: -180) //RandomCHallenge
        boardNodes[4].position = CGPoint(x: 450 , y: -120) //2T1L
        boardNodes[5].position = CGPoint(x: 470 , y: 0) // WY
        boardNodes[6].position = CGPoint(x: 420 , y: 80) //ToD
        boardNodes[7].position = CGPoint(x: 320 , y: 110) //RandomChallenge
        boardNodes[8].position = CGPoint(x: 210 , y: 60) //2T1L
        boardNodes[9].position = CGPoint(x: 60 , y: -130) //TOD
        boardNodes[10].position = CGPoint(x: -10 , y: -210) //WY
        boardNodes[11].position = CGPoint(x: -90 , y: -250) //RandomChallenge
        boardNodes[12].position = CGPoint(x: -180 , y: -270) //WY
        boardNodes[13].position = CGPoint(x: -270 , y: -240) //ToD
        boardNodes[14].position = CGPoint(x: -355 , y: -205) //ToD
        boardNodes[15].position = CGPoint(x: -425 , y: -135) //RandomChallenge
        boardNodes[16].position = CGPoint(x: -460 , y: -50) //ForceMove
        boardNodes[17].position = CGPoint(x: -470 , y: 40) //2T1l
        boardNodes[18].position = CGPoint(x: -425 , y: 135) //2T1L
        boardNodes[19].position = CGPoint(x: -360 , y: 200) //RandomChallenge
        boardNodes[20].position = CGPoint(x: -270 , y: 240) //WY
        boardNodes[21].position = CGPoint(x: -170 , y: 260) //2T1L
        boardNodes[22].position = CGPoint(x: -80 , y: 240) //ToD
        boardNodes[23].position = CGPoint(x: 10 , y: 180) //RandomChallenge
        boardNodes[24].position = CGPoint(x: 70 , y: 90) //LetGo
        
        for _ in 0..<25 {
            let tileNode = CGPoint(x: 0, y: 0)
            pathNodes.append(tileNode)
        }
        pathNodes[0] = CGPoint(x: 70, y: -100)
        pathNodes[1] = CGPoint(x: 60, y: -85)
        pathNodes[2] = CGPoint(x: 70, y: -55)
        pathNodes[3] = CGPoint(x: 100, y: -10)
        pathNodes[4] = CGPoint(x: 70, y: 60)
        pathNodes[5] = CGPoint(x: 20, y: 120)
        pathNodes[6] = CGPoint(x: -50, y: 80)
        pathNodes[7] = CGPoint(x: -100, y: 10)
        pathNodes[8] = CGPoint(x: -110, y: -50)
        pathNodes[9] = CGPoint(x: -150, y: -190)
        pathNodes[10] = CGPoint(x: -70, y: -80)
        pathNodes[11] = CGPoint(x: -80, y: -40)
        pathNodes[12] = CGPoint(x: -90, y: -20)
        pathNodes[13] = CGPoint(x: -90, y: 30)
        pathNodes[14] = CGPoint(x: -85, y: 35)
        pathNodes[15] = CGPoint(x: -70, y: 70)
        pathNodes[16] = CGPoint(x: -35, y: 85)
        pathNodes[17] = CGPoint(x: -10, y: 90)
        pathNodes[18] = CGPoint(x: 45, y: 95)
        pathNodes[19] = CGPoint(x: 65, y: 65)
        pathNodes[20] = CGPoint(x: 90, y: 40)
        pathNodes[21] = CGPoint(x: 100, y: 20)
        pathNodes[22] = CGPoint(x: 90, y: -20)
        pathNodes[23] = CGPoint(x: 80, y: -60)
        pathNodes[24] = CGPoint(x: 70, y: -90)
        
        
        let startingBoardNode = boardNodes[0] // assuming you have an array of board nodes
        
        //--------------------------------------PLAYERS INITIATION------------------------------------------
        for player in 0..<playersDataArray.count {
            let startingBoardNode = boardNodes[playersDataArray[player].currentSteps]
            playersDataArray[player].pieceNode.position = startingBoardNode.position
            playersDataArray[player].pieceNode.isUserInteractionEnabled = true
            playersDataArray[player].pieceNode.name = "gamePiece"
            boardNode.addChild(playersDataArray[player].pieceNode)
        }
        
        // ------------------------------------DICE INITIATION----------------------------------------------
        var diceButtonTexture = SKTexture(imageNamed: "dice\(diceNumber)")
        diceButton = SKSpriteNode(texture: diceButtonTexture)
        diceButton?.size = CGSize(width: 200, height: 200)
        diceButton?.position = CGPoint(x: -180, y: 0)
        addChild(diceButton!)
        
        // ------------------------------------POP UP CONTAINER----------------------------------------------
        // ada method sendiri di bawah
        
        // ------------------------------------TEXT FIELDCONTAINER-------------------------------------------
        
    }
    
    // --------------------------------FUNC TO MOVE OBJECT--------------------------------------------------
    func movePiece(_ pieceNode: SKSpriteNode, toTile tileNode: Int) {
        // Calculate the position of the center of the tile node
        let targetPosition = boardNodes[tileNode].position
        
        // Calculate the duration of the movement based on the distance
        let dx = targetPosition.x - pieceNode.position.x
        let dy = targetPosition.y - pieceNode.position.y
        let distance = sqrt(dx*dx + dy*dy)
        let duration = TimeInterval(distance / 400.0) // adjust 100.0 as needed
        
        // Create an SKAction to move the piece to the target position
        let moveAction = SKAction.move(to: targetPosition, duration: duration)
        
        // Run the move action on the piece node
        pieceNode.run(moveAction)
        myObject.setPosition(position: targetPosition)
        // Thread.sleep(forTimeInterval: 1)
    }
    
    func movePiece1(_ pieceNode: SKSpriteNode, with diceNumber: Int, currentStep: Int, finalPosition: Int){
        let path = UIBezierPath()
        let startPosition = CGPoint(x: 0, y: 0)
        var newPosition = CGPoint(x: 0, y: 0)
        var pathPosition = currentStep+1
//        pieceNode.position = newPosition
        path.move(to: startPosition)
        if pathPosition == 25 {
            pathPosition = 0
            path.addLine(to: CGPoint(x: startPosition.x+pathNodes[pathPosition].x, y: startPosition.y+pathNodes[pathPosition].y))
            newPosition = CGPoint(x: startPosition.x+pathNodes[pathPosition].x, y: startPosition.y+pathNodes[pathPosition].y)
        } else {
            path.addLine(to: CGPoint(x: startPosition.x+pathNodes[pathPosition].x, y: startPosition.y+pathNodes[pathPosition].y))
            newPosition = CGPoint(x: startPosition.x+pathNodes[pathPosition].x, y: startPosition.y+pathNodes[pathPosition].y)
        }
//        pathPosition+=1
        for step in 1..<diceNumber {
            if pathPosition == 24 {

                path.addLine(to: CGPoint(x: newPosition.x+pathNodes[0].x, y: newPosition.y+pathNodes[0].y))
                newPosition = CGPoint(x: newPosition.x+pathNodes[0].x, y: newPosition.y+pathNodes[0].y)
                pathPosition = 0
            } else {


            path.addLine(to: CGPoint(x: newPosition.x+pathNodes[pathPosition+1].x, y: newPosition.y+pathNodes[pathPosition+1].y))
            newPosition = CGPoint(x: newPosition.x+pathNodes[pathPosition+1].x, y: newPosition.y+pathNodes[pathPosition+1].y)
            }
            pathPosition+=1
        }
        let moveAction = SKAction.follow(path.cgPath, speed: 500)
        
        pieceNode.run(moveAction)
        let targetPosition = boardNodes[finalPosition].position
        myObject.setPosition(position: targetPosition)
    }
    func presentSwiftUIView() {
        let swiftUIView = Camera()
        if let viewController = self.view?.window?.rootViewController {
            let hostingController = UIHostingController(rootView: swiftUIView)
            viewController.present(hostingController, animated: true, completion: nil)
        }
    }

    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
//    playerBgArray[0].texture = SKTexture(imageNamed: "background_player_info_selected")
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
//        var playerBgArray = [self.playerInfoBgTexture1,self.playerInfoBgTexture2,self.playerInfoBgTexture3,self.playerInfoBgTexture4]
//        playerBgArray[currentPlayerIndex].texture = SKTexture(imageNamed: "background_player_info_selected")
//        if currentPlayerIndex != 0 {
//            playerBgArray[currentPlayerIndex - 1].texture = SKTexture(imageNamed: "background_player_info")
//        }
//        else {
//            playerBgArray[playersDataArray.count-1].texture = SKTexture(imageNamed: "background_player_info")
//        }
        
//        playerInfoBgTexture4.texture = SKTexture(imageNamed: "background_player_info_selected")
        if diceButton?.contains(touchLocation) == true {
            // print(currentPlayer)
            
            let diceNumber = rollDice()
            let diceButtonTexture = SKTexture(imageNamed: "dice\(diceNumber)")
            diceButton?.texture = diceButtonTexture
            var count = 0
            
            let diceRollTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] timer in
                count += 1
                if count == 7 {
                    timer.invalidate()
                    return
                }
                let diceNumber = self?.rollDice() ?? 1
                let diceButtonTexture = SKTexture(imageNamed: "dice\(diceNumber)")
                self?.diceButton?.run(SKAction.setTexture(diceButtonTexture), completion: { [self] in
                    if count == 6 {
                        

                        self!.diceNumberFix = 4
                        var startPosition = playersDataArray[self!.currentPlayerIndex].currentSteps
                        var move = playersDataArray[self!.currentPlayerIndex].currentSteps + self!.diceNumberFix//
//                        var move = playersDataArray[self!.currentPlayerIndex].currentSteps + 4
                        playersDataArray[self!.currentPlayerIndex].currentSteps = move
                        print ("current move = \(move)")
                        
                        if move >= 25 {
                            move = move - 25
                            playersDataArray[self!.currentPlayerIndex].currentSteps = move
                            playersDataArray[self!.currentPlayerIndex].currentPoin = playersDataArray[self!.currentPlayerIndex].currentPoin + 150
                            var startPosition = playersDataArray[self!.currentPlayerIndex].currentSteps
                        }
                        self!.movePiece1(playersDataArray[self!.currentPlayerIndex].pieceNode, with: self!.diceNumberFix, currentStep: startPosition, finalPosition: move)
                        for i in 0..<self!.playerCoinTextArray.count {
                            self!.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                        }
                        print("namanya: \(playersDataArray[self!.currentPlayerIndex].playersName), dan poinnya sebelum di proses: \(playersDataArray[self!.currentPlayerIndex].currentPoin)")
                        
                        self!.currentPlayerIndex += 1
                        if self!.currentPlayerIndex >= playersDataArray.count {
                            self!.currentPlayerIndex = 0
                        }
                        self!.playerBgArray[self!.currentPlayerIndex].texture = SKTexture(imageNamed: "background_player_info_selected")
                        if self!.currentPlayerIndex != 0 {
                            self!.playerBgArray[self!.currentPlayerIndex - 1].texture = SKTexture(imageNamed: "background_player_info")
                        }
                        else {
                            self!.playerBgArray[playersDataArray.count-1].texture = SKTexture(imageNamed: "background_player_info")
                        }
//                        print("lewat sini")
//                        print("current player index diatas = \(self!.currentPlayerIndex)")
                        self?.countShown = 0
                        var poinSebelum = playersDataArray[self!.currentPlayerIndex].currentPoin
                    }
                })
            }


            
        } else if buttonFrame?.contains(touchLocation) == true {
            diceButton?.position = CGPoint(x: -180, y: 0)
            
            popUpContainer?.removeFromParent()
            skView?.removeFromSuperview()
            
            let firstPrompt = textField?.text
            self.userInfo = ["FirstPrompt": firstPrompt ?? ""]
            self.userInfoBackup = self.userInfo
            cardArray[self.move].firstPrompt = self.userInfoBackup?["FirstPrompt"] as! String
            self.countShown = 2
            
            let secondPrompt = textField2?.text
            self.userInfo = ["SecondPrompt": secondPrompt ?? ""]
            self.userInfoBackup = self.userInfo
            cardArray[self.move].secondPrompt = self.userInfoBackup?["SecondPrompt"] as! String
            self.countShown = 2
            
            let thirdPrompt = textField3?.text
            self.userInfo = ["ThirdPrompt": thirdPrompt ?? ""]
            self.userInfoBackup = self.userInfo
            cardArray[self.move].thirdPrompt = self.userInfoBackup?["ThirdPrompt"] as! String
            self.countShown = 2
            
            cardArray[self.move].correctPrompt = self.selectedPrompt
            
            print(cardArray[self.move].firstPrompt)
            print(cardArray[self.move].secondPrompt)
            print(cardArray[self.move].thirdPrompt)
            
            print(selectedPrompt)
            print(cardArray[self.move].correctPrompt)
            
        } else if circleNode?.contains(touchLocation) == true {
            firstCircleClicked.toggle()
            selectedPrompt = "firstPrompt"
            
            //check list label on circle
            checkListLabel = SKLabelNode(text: "✓")
            checkListLabel?.fontName = "AvenirNext-Bold"
            checkListLabel?.fontColor = .white
            checkListLabel?.fontSize = 50
            checkListLabel?.position = CGPoint(x: 0, y: -17)
            
            checkListLabel?.removeFromParent()
            circleNode?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode?.addChild(checkListLabel!)
            
            circleNode2?.fillColor = UIColor.white
            secondCircleClicked = false
            
        } else if circleNode2?.contains(touchLocation) == true {
            secondCircleClicked.toggle()
            selectedPrompt = "secondPrompt"
            
            //check list label on circle
            checkListLabel = SKLabelNode(text: "✓")
            checkListLabel?.fontName = "AvenirNext-Bold"
            checkListLabel?.fontColor = .white
            checkListLabel?.fontSize = 50
            checkListLabel?.position = CGPoint(x: 0, y: -17)
            
            checkListLabel?.removeFromParent()
            circleNode2?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode2?.addChild(checkListLabel!)
            
            circleNode?.fillColor = UIColor.white
            firstCircleClicked = false
            
        } else if circleNode3?.contains(touchLocation) == true {
            thirdCircleClicked.toggle()
            selectedPrompt = "firstPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -10)
            
            lieLabel?.removeFromParent()
            circleNode3?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode3?.addChild(lieLabel!)
            
            circleNode4?.fillColor = UIColor.white
            circleNode5?.fillColor = UIColor.white
            
            fourthCircleClicked = false
            fifthCircleClicked = false
            
        } else if circleNode4?.contains(touchLocation) == true {
            fourthCircleClicked.toggle()
            selectedPrompt = "secondPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -10)
            
            lieLabel?.removeFromParent()
            circleNode4?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode4?.addChild(lieLabel!)
            
            circleNode3?.fillColor = UIColor.white
            circleNode5?.fillColor = UIColor.white
            
            thirdCircleClicked = false
            fifthCircleClicked = false
            
        } else if circleNode5?.contains(touchLocation) == true {
            fifthCircleClicked.toggle()
            selectedPrompt = "thirdPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -10)
            
            lieLabel?.removeFromParent()
            circleNode5?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode5?.addChild(lieLabel!)
            
            circleNode3?.fillColor = UIColor.white
            circleNode4?.fillColor = UIColor.white
            
            thirdCircleClicked = false
            fourthCircleClicked = false
            
        } else if dareButtonFrame?.contains(touchLocation) == true {
            popUpContainer?.removeFromParent()
            addPopUpContainer3(title: "DARE")
        } else if truthButtonFrame?.contains(touchLocation) == true {
            popUpContainer?.removeFromParent()
            addPopUpContainer3(title: "TRUTH")
        } else if buyButtonFrame?.contains(touchLocation) == true {
            popUpContainer?.removeFromParent()
            buy = true
            addPopUpContainer2()
        } else if skipButtonFrame?.contains(touchLocation) == true {
            diceButton?.position = CGPoint(x: -180, y: 0)
            popUpContainer?.removeFromParent()
            
            buy = false
        }
        //z
    }
    
    func addPopUpContainer() {
        diceButton?.position = CGPoint(x: 1000, y: 0)
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 600))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "2 TRUTH 1 LIE")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 220)
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -220)
        
        buttonLabel = SKLabelNode(text: "NEXT")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -19)
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField?.leftView = leftPaddingView
        textField?.leftViewMode = .always
        
        circleNode3 = SKShapeNode(circleOfRadius: 40)
        circleNode3?.fillColor = UIColor.white
        circleNode3?.lineWidth = 2
        circleNode3?.position = CGPoint(x: -370, y: 132)
        
        //second text field
        let textField2Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
        textField2 = UITextField(frame: textField2Frame)
        textField2?.backgroundColor = UIColor.white
        textField2?.placeholder = "Enter your prompt"
        textField2?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPadding2View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField2?.leftView = leftPadding2View
        textField2?.leftViewMode = .always
        
        circleNode4 = SKShapeNode(circleOfRadius: 40)
        circleNode4?.fillColor = UIColor.white
        circleNode4?.lineWidth = 2
        circleNode4?.position = CGPoint(x: -370, y: 15)
        
        //third text field
        let textField3Frame = CGRect(origin: CGPoint(x: 0, y: 200), size: CGSize(width: 600, height: 70))
        textField3 = UITextField(frame: textField3Frame)
        textField3?.backgroundColor = UIColor.white
        textField3?.placeholder = "Enter your prompt"
        textField3?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPadding3View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField3?.leftView = leftPadding3View
        textField3?.leftViewMode = .always
        
        circleNode5 = SKShapeNode(circleOfRadius: 40)
        circleNode5?.fillColor = UIColor.white
        circleNode5?.lineWidth = 2
        circleNode5?.position = CGPoint(x: -370, y: -103)
        
        //frame for text field
        let sceneFrame = CGRect(origin: .zero, size: CGSize(width: 520, height: 300))
        let scene = SKScene(size: sceneFrame.size)
        scene.backgroundColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        scene.view?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        skView = SKView(frame: sceneFrame)
        skView?.addSubview(textField!)
        skView?.addSubview(textField2!)
        skView?.addSubview(textField3!)
        skView?.presentScene(scene)
        
        if let view = self.view {
            skView?.center = view.center
            view.addSubview(skView!)
            popUpContainer?.inputView?.addSubview(skView!)
        }
        
        addChild(popUpContainer!)
        buttonFrame?.addChild(buttonLabel!)
        popUpContainer?.addChild(buttonFrame!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(circleNode3!)
        popUpContainer?.addChild(circleNode4!)
        popUpContainer?.addChild(circleNode5!)
    }
    
    
    func addPopUpContainerIfOwned() {
        diceButton?.position = CGPoint(x: 1000, y: 0)
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 600))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "2 TRUTH 1 LIE")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 220)
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -220)
        
        buttonLabel = SKLabelNode(text: "NEXT")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -19)
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        
        let textLabelFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 600, height: 70))
        textLabel = UILabel(frame: textLabelFrame)
        textLabel?.backgroundColor = UIColor.white
        textLabel?.layer.cornerRadius = textFieldFrame.size.height
        textLabel?.text = "\(cardArray[move].firstPrompt)"
//
//        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textLabelFrame.size.height))
//        textLabel.leftView = leftPaddingView
//        textLabel.leftViewMode = .always
        
        
//        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
//        textField?.leftView = leftPaddingView
//        textField?.leftViewMode = .always
        
        circleNode3 = SKShapeNode(circleOfRadius: 40)
        circleNode3?.fillColor = UIColor.white
        circleNode3?.lineWidth = 2
        circleNode3?.position = CGPoint(x: -370, y: 132)
        
        let textLabel2Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
        textLabel2 = UILabel(frame: textLabel2Frame)
        textLabel2?.backgroundColor = UIColor.white
        textLabel2?.layer.cornerRadius = textLabel2Frame.size.height / 2
        textLabel?.text = "\(cardArray[move].secondPrompt)"
        
        
        
        //second text field
//        let textField2Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
//        textField2 = UITextField(frame: textField2Frame)
//        textField2?.backgroundColor = UIColor.white
//        textField2?.placeholder = "Enter your prompt"
//        textField2?.layer.cornerRadius = textFieldFrame.size.height / 2
//
//        let leftPadding2View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
//        textField2?.leftView = leftPadding2View
//        textField2?.leftViewMode = .always
        
        circleNode4 = SKShapeNode(circleOfRadius: 40)
        circleNode4?.fillColor = UIColor.white
        circleNode4?.lineWidth = 2
        circleNode4?.position = CGPoint(x: -370, y: 15)
        
        //third text field
        let textField3Frame = CGRect(origin: CGPoint(x: 0, y: 200), size: CGSize(width: 600, height: 70))
        textField3 = UITextField(frame: textField3Frame)
        textField3?.backgroundColor = UIColor.white
        textField3?.placeholder = "Enter your prompt"
        textField3?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let textLabel3Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
        textLabel3 = UILabel(frame: textLabel3Frame)
        textLabel3?.backgroundColor = UIColor.white
        textLabel3?.layer.cornerRadius = textLabel3Frame.size.height / 2
        textLabel3?.text = "\(cardArray[move].thirdPrompt)"
        
//        let leftPadding3View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
//        textField3?.leftView = leftPadding3View
//        textField3?.leftViewMode = .always
        
        circleNode5 = SKShapeNode(circleOfRadius: 40)
        circleNode5?.fillColor = UIColor.white
        circleNode5?.lineWidth = 2
        circleNode5?.position = CGPoint(x: -370, y: -103)
        
        //frame for text field
        let sceneFrame = CGRect(origin: .zero, size: CGSize(width: 520, height: 300))
        let scene = SKScene(size: sceneFrame.size)
        scene.backgroundColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        scene.view?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        skView = SKView(frame: sceneFrame)
        skView?.addSubview(textField!)
        skView?.addSubview(textField2!)
        skView?.addSubview(textField3!)
        skView?.presentScene(scene)
        
        if let view = self.view {
            skView?.center = view.center
            view.addSubview(skView!)
            popUpContainer?.inputView?.addSubview(skView!)
        }
        
        addChild(popUpContainer!)
        buttonFrame?.addChild(buttonLabel!)
        popUpContainer?.addChild(buttonFrame!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(circleNode3!)
        popUpContainer?.addChild(circleNode4!)
        popUpContainer?.addChild(circleNode5!)
    }
    
    
    
    
    func addPopUpContainer2() {
        diceButton?.position = CGPoint(x: 1000, y: 0)
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 480))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "WOULD YOU RATHER")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 160)
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -160)
        
        buttonLabel = SKLabelNode(text: "NEXT")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -177)
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField?.leftView = leftPaddingView
        textField?.leftViewMode = .always
        
        circleNode = SKShapeNode(circleOfRadius: 40)
        circleNode?.fillColor = UIColor.white
        circleNode?.lineWidth = 2
        circleNode?.position = CGPoint(x: -370, y: 75)
        
        //second text field
        let textField2Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
        textField2 = UITextField(frame: textField2Frame)
        textField2?.backgroundColor = UIColor.white
        textField2?.placeholder = "Enter your prompt"
        textField2?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPadding2View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField2?.leftView = leftPadding2View
        textField2?.leftViewMode = .always
        
        circleNode2 = SKShapeNode(circleOfRadius: 40)
        circleNode2?.fillColor = UIColor.white
        circleNode2?.lineWidth = 2
        circleNode2?.position = CGPoint(x: -370, y: -40)
        
        //frame for text field
        let sceneFrame = CGRect(origin: .zero, size: CGSize(width: 520, height: 200))
        let scene = SKScene(size: sceneFrame.size)
        scene.backgroundColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        scene.view?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        skView = SKView(frame: sceneFrame)
        skView?.addSubview(textField!)
        skView?.addSubview(textField2!)
        skView?.presentScene(scene)
        
        if let view = self.view {
            skView?.center = view.center
            view.addSubview(skView!)
            popUpContainer?.inputView?.addSubview(skView!)
        }
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(buttonFrame!)
        popUpContainer?.addChild(buttonLabel!)
        popUpContainer?.addChild(circleNode!)
        popUpContainer?.addChild(circleNode2!)
    }
    
    func addPopUpContainer3(title: String) {
        diceButton?.position = CGPoint(x: 1000, y: 0)
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 380))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: title)
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 100)
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -115)
        
        buttonLabel = SKLabelNode(text: "NEXT")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -135)
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: -11), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField?.leftView = leftPaddingView
        textField?.leftViewMode = .always
        
        //frame for text field
        let sceneFrame = CGRect(origin: .zero, size: CGSize(width: 600, height: 70))
        let scene = SKScene(size: sceneFrame.size)
        scene.backgroundColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        scene.view?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        skView = SKView(frame: sceneFrame)
        skView?.addSubview(textField!)
        skView?.presentScene(scene)
        
        if let view = self.view {
            skView?.center = view.center
            view.addSubview(skView!)
            popUpContainer?.inputView?.addSubview(skView!)
        }
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(buttonLabel!)
        popUpContainer?.addChild(buttonFrame!)
    }
    
    func addBuyOfferPopUp() {
        diceButton?.position = CGPoint(x: 1000, y: 0)
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 350))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "YOU LANDED ON")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 80)
        
        let challengeNameLabel = SKLabelNode(text: challengeName)
        challengeNameLabel.fontName = "AvenirNext-Bold"
        challengeNameLabel.fontColor = UIColor(red: 53/255, green: 157/255, blue: 158/255, alpha: 100)
        challengeNameLabel.fontSize = 55
        challengeNameLabel.position = CGPoint(x: 0, y: 10)
        
        //skip button
        skipButtonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        skipButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        skipButtonFrame?.position = CGPoint(x: 210, y: -82)
        
        skipButtonLabel = SKLabelNode(text: "SKIP")
        skipButtonLabel?.fontName = "AvenirNext-Bold"
        skipButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        skipButtonLabel?.fontSize = 50
        skipButtonLabel?.position = CGPoint(x: 210, y: -100)
        
        //buy button
        buyButtonFrame = SKShapeNode(rectOf: CGSize(width: 365, height: 85), cornerRadius: 40)
        buyButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buyButtonFrame?.position = CGPoint(x: -160, y: -82)
        
        buyButtonLabel = SKLabelNode(text: "BUY      180")
        buyButtonLabel?.fontName = "AvenirNext-Bold"
        buyButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buyButtonLabel?.fontSize = 50
        buyButtonLabel?.position = CGPoint(x: -160, y: -100)
        
        //coin image for button
        let coinImage = SKSpriteNode(imageNamed: "coin")
        coinImage.position = CGPoint(x: -157, y: -80)
        coinImage.size = CGSize(width: 50, height: 50)
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(challengeNameLabel)
        popUpContainer?.addChild(buyButtonLabel!)
        popUpContainer?.addChild(buyButtonFrame!)
        popUpContainer?.addChild(skipButtonLabel!)
        popUpContainer?.addChild(skipButtonFrame!)
        popUpContainer?.addChild(coinImage)
    }
    
    func addChallengePopUp() {
        diceButton?.position = CGPoint(x: 1000, y: 0)
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1150, height: 350))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "CHALLENGE")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 100)
        
        //sub title label
        let subTitleLabel = SKLabelNode(text: "Please tell us...")
//        subTitleLabel.fontName = "AvenirNext"
        subTitleLabel.fontColor = UIColor.black
        subTitleLabel.fontSize = 25
        subTitleLabel.position = CGPoint(x: 0, y: 40)
        
        //challenge label
        let challengeNameLabel = SKLabelNode(text: challenges.randomElement()?.challengePrompt)
//        challengeNameLabel.fontName = "AvenirNext"
        challengeNameLabel.fontColor = UIColor.black
        challengeNameLabel.fontSize = 25
        challengeNameLabel.position = CGPoint(x: 0, y: -15)
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -105)
        
        buttonLabel = SKLabelNode(text: "DONE")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -125)
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(subTitleLabel)
        popUpContainer?.addChild(challengeNameLabel)
        popUpContainer?.addChild(buttonLabel!)
        popUpContainer?.addChild(buttonFrame!)
    }
    
    func addTODPopUp() {
        diceButton?.position = CGPoint(x: 1000, y: 0)
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 800, height: 200))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //OR label
        let titleLabel = SKLabelNode(text: "OR")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 40
        titleLabel.position = CGPoint(x: 0, y: -17)

        //skip button
        dareButtonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        dareButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        dareButtonFrame?.position = CGPoint(x: 190, y: 0)
            
        dareButtonLabel = SKLabelNode(text: "DARE")
        dareButtonLabel?.fontName = "AvenirNext-Bold"
        dareButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        dareButtonLabel?.fontSize = 50
        dareButtonLabel?.position = CGPoint(x: 190, y: -17)
        
        //buy button
        truthButtonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        truthButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        truthButtonFrame?.position = CGPoint(x: -188, y: 0)
        
        truthButtonLabel = SKLabelNode(text: "TRUTH")
        truthButtonLabel?.fontName = "AvenirNext-Bold"
        truthButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        truthButtonLabel?.fontSize = 50
        truthButtonLabel?.position = CGPoint(x: -188, y: -17)
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(dareButtonFrame!)
        popUpContainer?.addChild(dareButtonLabel!)
        popUpContainer?.addChild(truthButtonFrame!)
        popUpContainer?.addChild(truthButtonLabel!)
    }
    
    override func didEvaluateActions() {
        var objPosition = myObject.objPosition
        var cardNode : Int = 0
        var lastOwnerIndex : Int = 0
        var currentPlayerIndexForPopUp : Int = 0
        if currentPlayerIndex != 0 {
            currentPlayerIndexForPopUp = currentPlayerIndex - 1
        }
        else {
            currentPlayerIndexForPopUp = 3
        }
        
        for i in 0...24 {
            if boardNodes[i].position == objPosition {
                cardNode = i
//                print("ketemu \(i)")
            }
        }
        

        
        if ((objPosition.x == 510 && objPosition.y == 120) || (objPosition.x == 70 && objPosition.y == -150) || (objPosition.x == 450 && objPosition.y == -120) || (objPosition.x == 210 && objPosition.y == 60) || (objPosition.x == -425 && objPosition.y == 135) || (objPosition.x == -170 && objPosition.y == 260)) && countShown == 0 {
            challengeName = "2 Truth 1 Lie"
            if cardArray[cardNode].cardOwner != playersDataArray[currentPlayerIndexForPopUp].playersName {
                if cardArray[cardNode].cardOwner == "Null" {
                    //                addBuyOfferPopUp()
                     // bikin pilhan mo beli apa engga
                    if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 150 {
                        
                        let alertController = UIAlertController(title: "do you want to buy this field?", message: challengeName, preferredStyle: .alert)
                        let yesAction = UIAlertAction(title: "Buy", style: .default) { [weak self] (_) in
                            self?.buy = true
    //                        self?.addPopUpContainer()  //2t1l
                            cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                            playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 150
//                            print ("player \(playersDataArray[currentPlayerIndexForPopUp].playersName) delta poin = \(poinSebelum - playersDataArray[currentPlayerIndexForPopUp].currentPoin)")
                            for i in 0..<self!.playerCoinTextArray.count {
                                self!.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                            }
                            print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di 2 Truth 1 Lie board ke \(cardNode)")
                        }
        
                        let noAction = UIAlertAction(title: "Skip", style: .cancel) { [weak self] (_) in
                            self?.buy = false
                            //                self?.countShown = 1
                        }
                        alertController.addAction(yesAction)
                        alertController.addAction(noAction)
                        delay(1){
                            self.view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                        }
                        
                        
                    }
                    else {
                        // TAMPILAN PEMENANG
                    }
//                    print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di 2 Truth 1 Lie board ke \(cardNode)")
                }
                
                else {
                    if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 150 {
                        //                      TAMPILAN POPUP CHALLENGENYA. CHECK RETURNNYA. AKU PAKE VARIABLE RETURNANSWER DULU YAAA
                        for i in 0...playersDataArray.count - 1 {
                            if cardArray[cardNode].cardOwner == playersDataArray[i].playersName {
                                lastOwnerIndex = i
                                
                            }
                        }
                        if returnAnswer == true { //mau beli
                            if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 170 {
                                let alertController = UIAlertController(title: "You're correct! do you want to buy this field?", message: challengeName, preferredStyle: .alert)
                                let yesAction = UIAlertAction(title: "Buy", style: .default) { [weak self] (_) in
                                    self?.buy = true
            //                        self?.addPopUpContainerIfOwned()  //buat tampilan untuk pop up pertanyaan sebelumnya untuk 2T1L]
                                    cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                                    playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 170
                                    
                                    playersDataArray[lastOwnerIndex].currentPoin += 170
                                    for i in 0..<self!.playerCoinTextArray.count {
                                        self!.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                                    }
                                    print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di 2 Truth 1 Lie board ke \(cardNode)")
                                }
                
                                let noAction = UIAlertAction(title: "Skip", style: .cancel) { [weak self] (_) in
                                    self?.buy = false
            //                        self?.addPopUpContainerIfOwned()
                                    //                self?.countShown = 1
                                }
                                alertController.addAction(yesAction)
                                alertController.addAction(noAction)
                
                                view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }
                            else {
//                                TAMPILAN PEMENANG
                            }
                            
                        }
                        else { //kalo gamau beli
                            cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                            playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 150
                            
                            playersDataArray[lastOwnerIndex].currentPoin += 150
                            for i in 0..<self.playerCoinTextArray.count {
                                self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                            }
                        }
                        
                        print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di 2 Truth 1 Lie board ke \(cardNode)")
                    }
                    else {
                        // TAMPILAN PEMENANG
                    }
                }
            }

            countShown = 1
            
        } else if ((objPosition.x == 470 && objPosition.y == 0) || (objPosition.x == 280 && objPosition.y == -170) || (objPosition.x == -10 && objPosition.y == -210) || (objPosition.x == -180 && objPosition.y == -270) || (objPosition.x == -270 && objPosition.y == 240) || (objPosition.x == -470 && objPosition.y == 40)) && countShown == 0 {
            
            
            
            challengeName = "Would You Rather"
//            addBuyOfferPopUp()
            
            if cardArray[cardNode].cardOwner != playersDataArray[currentPlayerIndexForPopUp].playersName {

//                addBuyOfferPopUp()
                if cardArray[cardNode].cardOwner == "Null" {
                    if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 120 {
                        let alertController = UIAlertController(title: "YOU LANDED ON", message: challengeName, preferredStyle: .alert)
                        let yesAction = UIAlertAction(title: "Buy", style: .default) { [weak self] (_) in
                            self?.buy = true
    //                        self?.addPopUpContainer()  //2t1l
                            cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                            playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 120
                            for i in 0..<self!.playerCoinTextArray.count {
                                self!.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                            }
                            print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di WY board ke \(cardNode)")
                        }
        
                        let noAction = UIAlertAction(title: "Skip", style: .cancel) { [weak self] (_) in
                            self?.buy = false
                            //                self?.countShown = 1
                        }
                        alertController.addAction(yesAction)
                        alertController.addAction(noAction)
        
                        view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                    else {
                        // TAMPILAN PEMENANG
                    }
                    
                }
                else {
                    if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 120 {
                        //                      TAMPILAN POPUP CHALLENGENYA. CHECK RETURNNYA. AKU PAKE VARIABLE RETURNANSWER DULU YAAA
                        for i in 0...playersDataArray.count - 1 {
                            if cardArray[cardNode].cardOwner == playersDataArray[i].playersName {
                                lastOwnerIndex = i
                                
                            }
                        }
                        if returnAnswer == true {
                            if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 140 {
                                let alertController = UIAlertController(title: "YOU LANDED ON", message: challengeName, preferredStyle: .alert)
                                let yesAction = UIAlertAction(title: "Buy", style: .default) { [weak self] (_) in
                                    self?.buy = true
            //                        self?.addPopUpContainerIfOwned()  //buat tampilan untuk pop up pertanyaan sebelumnya untuk 2T1L
                                    cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                                    playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 140 //check lagi ngurangin berapa di rules
                                    playersDataArray[lastOwnerIndex].currentPoin += 140
                                    for i in 0..<self!.playerCoinTextArray.count {
                                        self!.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                                    }
                                    print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di WY board ke \(cardNode)")
                                }
                
                                let noAction = UIAlertAction(title: "Skip", style: .cancel) { [weak self] (_) in
                                    self?.buy = false
            //                        self?.addPopUpContainerIfOwned()
                                    //                self?.countShown = 1
                                }
                                alertController.addAction(yesAction)
                                alertController.addAction(noAction)
                
                                view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)

                            }
                            else {
//                  TAMPILAN PEMENANG
                            }
                            
                        }
                        else {
                            cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                            playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 120 //check lagi ngurangin berapa di rules
                            playersDataArray[lastOwnerIndex].currentPoin += 120
                            for i in 0..<self.playerCoinTextArray.count {
                                self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                            }
                            print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di WY board ke \(cardNode)")
                        }

                        
                    }
                    else {
                        // TAMPILAN PEMENANG
                    }
                }
            }

            countShown = 1
            
        }
        else if ((objPosition.x == 420 && objPosition.y == 80) || (objPosition.x == 60 && objPosition.y == -130) || (objPosition.x == -270 && objPosition.y == -240) || (objPosition.x == -355 && objPosition.y == -205) || (objPosition.x == -80 && objPosition.y == 240)) && countShown == 0 {
            
            challengeName = "Truth or Dare"
//            addBuyOfferPopUp()
            if cardArray[cardNode].cardOwner != playersDataArray[currentPlayerIndexForPopUp].playersName {
//                addBuyOfferPopUp()
                if cardArray[cardNode].cardOwner == "Null" {
                    if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 180 {
                        let alertController = UIAlertController(title: "YOU LANDED ON", message: challengeName, preferredStyle: .alert)
                        let yesAction = UIAlertAction(title: "Buy", style: .default) { [weak self] (_) in
                            self?.buy = true
    //                        self?.addPopUpContainer()  //2t1l
                            cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                            playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 180
                            for i in 0..<self!.playerCoinTextArray.count {
                                self!.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                            }
                            print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di Truth or Dare board ke \(cardNode)")
                        }
        
                        let noAction = UIAlertAction(title: "Skip", style: .cancel) { [weak self] (_) in
                            self?.buy = false
                            //                self?.countShown = 1
                        }
                        alertController.addAction(yesAction)
                        alertController.addAction(noAction)
        
                        view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                    else {
                        // TAMPILAN PEMENANG
                    }
                    
                }
                else {
                    if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 180 {
                        
                        //                      TAMPILAN POPUP CHALLENGENYA. CHECK RETURNNYA. AKU PAKE VARIABLE RETURNANSWER DULU YAAA
                        for i in 0...playersDataArray.count - 1 {
                            if cardArray[cardNode].cardOwner == playersDataArray[i].playersName {
                                lastOwnerIndex = i
                                
                            }
                        }
                        
                        if returnAnswer == true {
                            if playersDataArray[currentPlayerIndexForPopUp].currentPoin > 200 {
                                let alertController = UIAlertController(title: "YOU LANDED ON", message: challengeName, preferredStyle: .alert)
                                let yesAction = UIAlertAction(title: "Buy", style: .default) { [weak self] (_) in
                                    self?.buy = true
            //                        self?.addPopUpContainerIfOwned()  //buat tampilan untuk pop up pertanyaan sebelumnya untuk 2T1L
                                    for i in 0...playersDataArray.count - 1 {
                                        if cardArray[cardNode].cardOwner == playersDataArray[i].playersName {
                                            lastOwnerIndex = i
                                            
                                        }
                                    }
                                    cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                                    playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 200 //check lagi ngurangin berapa di rules
                                    playersDataArray[lastOwnerIndex].currentPoin += 200
                                    for i in 0..<self!.playerCoinTextArray.count {
                                        self!.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                                    }
                                    print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di Truth or Dare board ke \(cardNode)")
                                }
                
                                let noAction = UIAlertAction(title: "Skip", style: .cancel) { [weak self] (_) in
                                    self?.buy = false
            //                        self?.addPopUpContainerIfOwned()
                                    //                self?.countShown = 1
                                }
                                alertController.addAction(yesAction)
                                alertController.addAction(noAction)
                
                                view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                            }
                            else {
//                                TAMPILAN PEMENANG
                            }

                        }
                        else {
                            cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                            playersDataArray[currentPlayerIndexForPopUp].currentPoin -= 180 //check lagi ngurangin berapa di rules
                            playersDataArray[lastOwnerIndex].currentPoin += 180
                            for i in 0..<self.playerCoinTextArray.count {
                                self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                            }
                            print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di Truth or Dare board ke \(cardNode)")
                        }
                    }
                    else {
                        // TAMPILAN PEMENANG
                    }

                }
            }

            countShown = 1
            
        } else if ((objPosition.x == 380 && objPosition.y == -180) || (objPosition.x == 320 && objPosition.y == 110) || (objPosition.x == -90 && objPosition.y == -250) || (objPosition.x == -425 && objPosition.y == -135) || (objPosition.x == -360 && objPosition.y == 200) || (objPosition.x == 10 && objPosition.y == 180)) && countShown == 0 {
            
            self.addChallengePopUp()   //challenge
            // pastikan lagi
            countShown = 1
            
            
        } else if ((objPosition.x == 190 && objPosition.y == -110)) && countShown == 0 {
            
            print("Nyampe Safe House")  //safe house
            playersDataArray[currentPlayerIndexForPopUp].currentPoin = Int(Double(playersDataArray[currentPlayerIndexForPopUp].currentPoin) + Double(playersDataArray[currentPlayerIndexForPopUp].currentPoin) * 0.1)
            print("SAFE HOUSEEEE = \(playersDataArray[currentPlayerIndexForPopUp].currentPoin*Int(0.1))")
            for i in 0..<self.playerCoinTextArray.count {
                self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
            }
            print("poin safe house \(playersDataArray[currentPlayerIndexForPopUp].currentPoin)")
            countShown = 1
            print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di safehouse ke \(cardNode)")
            
        } else if ((objPosition.x == -460 && objPosition.y == -50)) && countShown == 0 {
            
            print("Nyampe Force Move")  //Force Move
            let randomPosition = Int.random(in: 0...24)
            let randomPlayer = Int.random(in: 0...playersDataArray.count-1)
            playersDataArray[randomPlayer].currentSteps=randomPosition
            
            countShown = 1
            print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses di force move di \(cardNode), manerik player \(playersDataArray[randomPlayer].playersName) ke \(randomPosition)")
            
        } else if ((objPosition.x == 70 && objPosition.y == 90)) && countShown == 0 {
            
            print("Nyampe Let Go")  //Let Go
            playersDataArray[currentPlayerIndexForPopUp].currentPoin = Int(Double(playersDataArray[currentPlayerIndexForPopUp].currentPoin) - Double(playersDataArray[currentPlayerIndexForPopUp].currentPoin) * 0.1)
            for i in 0..<self.playerCoinTextArray.count {
                self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
            }
            countShown = 1
            print("namanya: \(playersDataArray[currentPlayerIndexForPopUp].playersName), dan poinnya setelah  di proses: \(playersDataArray[currentPlayerIndexForPopUp].currentPoin),  di proses let go ke \(cardNode)")
            
        } else if ((objPosition.x == 130 && objPosition.y == -10)) && countShown == 0 {
            
            print("Nyampe Start")  //Start
            countShown = 1
            presentSwiftUIView()
            
        }
    }
    
    func rollDice() -> Int {
        return Int.random(in: 1...6)
    }
    
    func delay(_ seconds: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            closure()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}


//----------------------------------------------------------------------------------

