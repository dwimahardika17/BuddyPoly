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
        print("Objek diposisikan di \(objPosition)")
        print("update")
        print("update indah")
        print("update yuga")
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
    private var cameraCount: Bool = false
    
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
    private var mainMenuButtonFrame: SKShapeNode?
    private var mainMenuButtonLabel: SKLabelNode?
    
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
    
    private var diceClicked: Bool = false
    private var buyPopUpAppeared: Bool = false
    private var todPopUpAppeared: Bool = false
    private var challengePopUpAppeared: Bool = false
    private var popUpContainerAppeared: Bool = false
    private var popUpContainer2Appeared: Bool = false
    private var popUpContainer3Appeared: Bool = false
    private var leaderboardPopUpAppeared: Bool = false
    private var onAcquisitionMode: Bool = false
    
    private var overlayNode: SKSpriteNode?
    
    private var cardNode : Int = 0
    private var lastOwnerIndex : Int = 0
    private var currentPlayerIndexForPopUp : Int = 0
    private var playerInfoFrame1: SKShapeNode?
    private var currentCoin1 = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
    private var playerCoinTextArray = [SKLabelNode]()
    private var playerBgArray = [SKSpriteNode]()
    
    var playerCoin1 = SKLabelNode()
    var playerCoin2 = SKLabelNode()
    var playerCoin3 = SKLabelNode()
    var playerCoin4 = SKLabelNode()
    var playerInfoBgTexture1 = SKSpriteNode()
    var playerInfoBgTexture2 = SKSpriteNode()
    var playerInfoBgTexture3 = SKSpriteNode()
    var playerInfoBgTexture4 = SKSpriteNode()
    
    var isTruthClicked = false
    
    override func didMove(to view: SKView) {
        playerInfoBgTexture1 = SKSpriteNode(imageNamed: "background_player_info_selected")
        playerInfoBgTexture1.position = CGPoint(x: -(view.bounds.size.width/2)+170, y: view.bounds.size.height/2 - 120 )
        playerInfoBgTexture1.zPosition = -50
        playerInfoBgTexture1.size = CGSize(width: 300, height: 140)
        addChild(playerInfoBgTexture1)
        
        
        let playerInfoAva1 = SKSpriteNode(imageNamed: "playerfix1")
        playerInfoAva1.position = CGPoint(x: -(view.bounds.size.width/2)+70, y: view.bounds.size.height/2 - 120)
        playerInfoAva1.size = CGSize(width: 65, height: 78)
        addChild(playerInfoAva1)
        
        let coin1 = SKSpriteNode(imageNamed: "coin")
        coin1.position = CGPoint(x: -(view.bounds.size.width/2)+150, y: view.bounds.size.height/2 - 140 )
        coin1.size = CGSize(width: 51, height: 46)
        addChild(coin1)
        
        let playerName1 = SKLabelNode()
        playerName1.position = CGPoint(x: -(view.bounds.size.width/2)+190, y: view.bounds.size.height/2 - 110)
        playerName1.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerName1.fontName = "AvenirNext-Bold"
        playerName1.text = "\(playersDataArray[0].playersName)"
        playerInfoBgTexture1.zPosition = -3
        addChild(playerName1)
        
        playerCoin1.position = CGPoint(x: -(view.bounds.size.width/2)+220, y: view.bounds.size.height/2 - 150)
        playerCoin1.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerCoin1.fontName = "AvenirNext-Bold"
        playerCoin1.text = "\(playersDataArray[0].currentPoin)"
        addChild(playerCoin1)
//        current state player 2
        
        playerInfoBgTexture2 = SKSpriteNode(imageNamed: "background_player_info")
        playerInfoBgTexture2.position = CGPoint(x: (view.bounds.size.width/2)-170, y: view.bounds.size.height/2 - 120 )
        playerInfoBgTexture2.size = CGSize(width: 300, height: 140)
        playerInfoBgTexture2.zPosition = -1
        addChild(playerInfoBgTexture2)
        
        let playerInfoAva2 = SKSpriteNode(imageNamed: "playerfix2")
        playerInfoAva2.position = CGPoint(x: (view.bounds.size.width/2)-260, y: view.bounds.size.height/2 - 120)
        playerInfoAva2.size = CGSize(width: 65, height: 78)
        addChild(playerInfoAva2)
        
//        260 - 70 = 190
        
        let coin2 = SKSpriteNode(imageNamed: "coin")
        coin2.position = CGPoint(x: (view.bounds.size.width/2)-170, y: view.bounds.size.height/2 - 140  )
        coin2.size = CGSize(width: 51, height: 46)
        addChild(coin2)
        
        let playerName2 = SKLabelNode()
        playerName2.position = CGPoint(x: (view.bounds.size.width/2)-130, y: view.bounds.size.height/2 - 110)
        playerName2.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerName2.fontName = "AvenirNext-Bold"
        playerName2.text = "\(playersDataArray[1].playersName)"
        addChild(playerName2)
        
        playerCoin2.position = CGPoint(x: (view.bounds.size.width/2)-100, y: view.bounds.size.height/2 - 150)
        playerCoin2.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerCoin2.text = "\(playersDataArray[1].currentPoin)"
        playerCoin2.fontName = "AvenirNext-Bold"
        addChild(playerCoin2)
        
//        current state 3
        
        playerInfoBgTexture3 = SKSpriteNode(imageNamed: "background_player_info")
        playerInfoBgTexture3.position = CGPoint(x: (view.bounds.size.width/2)-170, y: -(view.bounds.size.height/2 - 120))
        playerInfoBgTexture3.zPosition = -2
        playerInfoBgTexture3.size = CGSize(width: 300, height: 140)
//        addChild(playerInfoBgTexture3)
        
        let playerInfoAva3 = SKSpriteNode(imageNamed: "playerfix3")
        playerInfoAva3.position = CGPoint(x: (view.bounds.size.width/2)-260, y: -(view.bounds.size.height/2 - 120))
        playerInfoAva3.size = CGSize(width: 65, height: 78)
//        addChild(playerInfoAva3)
        
        let coin3 = SKSpriteNode(imageNamed: "coin")
        coin3.position = CGPoint(x: (view.bounds.size.width/2)-170, y: -(view.bounds.size.height/2 - 100))
        coin3.size = CGSize(width: 51, height: 46)
//        addChild(coin3)
        
        let playerName3 = SKLabelNode()
        playerName3.position = CGPoint(x: (view.bounds.size.width/2)-130, y: -(view.bounds.size.height/2 - 130))
        playerName3.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        playerName3.fontName = "AvenirNext-Bold"
        
//        addChild(playerName3)
        
        playerCoin3.position = CGPoint(x: (view.bounds.size.width/2)-100, y: -(view.bounds.size.height/2 - 90))
        playerCoin3.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        
        playerCoin3.fontName = "AvenirNext-Bold"
//        addChild(playerCoin3)
        
//        current player4 initiation
        
//        playerInfoBgTexture4 = SKTexture(imageNamed: "background_player_info")

        playerInfoBgTexture4 = SKSpriteNode(imageNamed: "background_player_info")
        playerInfoBgTexture4.position = CGPoint(x: -(view.bounds.size.width/2)+170, y: -(view.bounds.size.height/2 - 120 ))
        playerInfoBgTexture4.zPosition = -10
        playerInfoBgTexture4.size = CGSize(width: 300, height: 140)
//        addChild(playerInfoBgTexture4)
        
        let playerInfoAva4 = SKSpriteNode(imageNamed: "playerfix4")
        playerInfoAva4.position = CGPoint(x: -(view.bounds.size.width/2)+70, y: -(view.bounds.size.height/2 - 120))
        playerInfoAva4.size = CGSize(width: 65, height: 78)
//        addChild(playerInfoAva4)
        
        let coin4 = SKSpriteNode(imageNamed: "coin")
        coin4.position = CGPoint(x: -(view.bounds.size.width/2)+150, y: -(view.bounds.size.height/2 - 100))
        coin4.size = CGSize(width: 51, height: 46)
//        addChild(coin4)
        
        let playerName4 = SKLabelNode()
        playerName4.position = CGPoint(x: -(view.bounds.size.width/2)+190, y: -(view.bounds.size.height/2 - 130))
        playerName4.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        
        playerName4.fontName = "AvenirNext-Bold"
//        addChild(playerName4)
        
        playerCoin4.position = CGPoint(x: -(view.bounds.size.width/2)+220, y: -(view.bounds.size.height/2 - 90))
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
            playerName3.text = "\(playersDataArray[2].playersName)"
            playerName4.text = "\(playersDataArray[3].playersName)"
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
            playerName3.text = "\(playersDataArray[2].playersName)"
        }
        
        //-----------------------------------BACKGROUND INITIATION--------------------------------------
        let background = SKSpriteNode(imageNamed: "newbgfix")
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
        
        boardNodes[0].position = CGPoint(x: 110 , y: -10) //START
        boardNodes[1].position = CGPoint(x: 170 , y: -100) //HOME
        boardNodes[2].position = CGPoint(x: 240 , y: -150) //WY
        boardNodes[3].position = CGPoint(x: 330 , y: -150) //RandomCHallenge
        boardNodes[4].position = CGPoint(x: 400 , y: -100) //2T1L
        boardNodes[5].position = CGPoint(x: 410 , y: -10) // WY
        boardNodes[6].position = CGPoint(x: 370 , y: 70) //ToD
        boardNodes[7].position = CGPoint(x: 280 , y: 90) //RandomChallenge
        boardNodes[8].position = CGPoint(x: 190 , y: 50) //2T1L
        boardNodes[9].position = CGPoint(x: 50 , y: -110) //TOD
        boardNodes[10].position = CGPoint(x: -5 , y: -180) //WY
        boardNodes[11].position = CGPoint(x: -80 , y: -220) //RandomChallenge
        boardNodes[12].position = CGPoint(x: -160 , y: -230) //WY
        boardNodes[13].position = CGPoint(x: -240 , y: -210) //ToD
        boardNodes[14].position = CGPoint(x: -315 , y: -180) //ToD
        boardNodes[15].position = CGPoint(x: -375 , y: -120) //RandomChallenge
        boardNodes[16].position = CGPoint(x: -410 , y: -40) //ForceMove
        boardNodes[17].position = CGPoint(x: -420 , y: 40) //2T1l
        boardNodes[18].position = CGPoint(x: -385 , y: 120) //2T1L
        boardNodes[19].position = CGPoint(x: -315 , y: 170) //RandomChallenge
        boardNodes[20].position = CGPoint(x: -240 , y: 210) //WY
        boardNodes[21].position = CGPoint(x: -150 , y: 230) //2T1L
        boardNodes[22].position = CGPoint(x: -60 , y: 210) //ToD
        boardNodes[23].position = CGPoint(x: 10 , y: 160) //RandomChallenge
        boardNodes[24].position = CGPoint(x: 70 , y: 80) //LetGo
        
        for _ in 0..<25 {
            let tileNode = CGPoint(x: 0, y: 0)
            pathNodes.append(tileNode)
        }
        
        pathNodes[0] = CGPoint(x: 40, y: -90)
        pathNodes[1] = CGPoint(x: 60, y: -90)
        pathNodes[2] = CGPoint(x: 70, y: -50)
        pathNodes[3] = CGPoint(x: 90, y: 0)
        pathNodes[4] = CGPoint(x: 70, y: 50)
        pathNodes[5] = CGPoint(x: 10, y: 90)
        pathNodes[6] = CGPoint(x: -40, y: 80)
        pathNodes[7] = CGPoint(x: -90, y: 20)
        pathNodes[8] = CGPoint(x: -90, y: -40)
        pathNodes[9] = CGPoint(x: -140, y: -160)
        pathNodes[10] = CGPoint(x: -55, y: -70)
        pathNodes[11] = CGPoint(x: -75, y: -40)
        pathNodes[12] = CGPoint(x: -80, y: -10)
        pathNodes[13] = CGPoint(x: -80, y: 20)
        pathNodes[14] = CGPoint(x: -75, y: 30)
        pathNodes[15] = CGPoint(x: -60, y: 60)
        pathNodes[16] = CGPoint(x: -35, y: 80)
        pathNodes[17] = CGPoint(x: -10, y: 80)
        pathNodes[18] = CGPoint(x: 35, y: 80)
        pathNodes[19] = CGPoint(x: 70, y: 50)
        pathNodes[20] = CGPoint(x: 75, y: 40)
        pathNodes[21] = CGPoint(x: 90, y: 20)
        pathNodes[22] = CGPoint(x: 90, y: -20)
        pathNodes[23] = CGPoint(x: 70, y: -60)
        pathNodes[24] = CGPoint(x: 60, y: -90)
        
        
        //--------------------------------------PLAYERS INITIATION------------------------------------------
        for player in 0..<playersDataArray.count {
            let startingBoardNode = boardNodes[playersDataArray[player].currentSteps]
            playersDataArray[player].pieceNode.position = startingBoardNode.position
            playersDataArray[player].pieceNode.isUserInteractionEnabled = true
            playersDataArray[player].pieceNode.name = "gamePiece"
            boardNode.addChild(playersDataArray[player].pieceNode)
        }
        
        // ------------------------------------DICE INITIATION----------------------------------------------
        let diceButtonTexture = SKTexture(imageNamed: "dice\(diceNumber)")
        diceButton = SKSpriteNode(texture: diceButtonTexture)
        diceButton?.size = CGSize(width: 170, height: 170)
        diceButton?.position = CGPoint(x: -160, y: 0)
        addChild(diceButton!)
        
        addOverlay()
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
        for _ in 1..<diceNumber {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        cameraCount = true
        
        if diceButton?.contains(touchLocation) == true && diceClicked == false {
            diceClicked = true
            
            let diceNumber = rollDice()
            let diceButtonTexture = SKTexture(imageNamed: "dice\(diceNumber)")
            diceButton?.texture = diceButtonTexture
            var count = 0
            var count2 = 0
            
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
                        self!.diceNumberFix = 3
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
            
        } else if buttonFrame?.contains(touchLocation) == true && (popUpContainerAppeared == true || popUpContainer2Appeared == true || popUpContainer3Appeared == true) && textFieldValidation() == true {
            popUpContainerAppeared = false
            popUpContainer2Appeared = false
            popUpContainer3Appeared = false
            overlayNode?.isHidden = true
            
            removePopUpContainer()
            
            if onAcquisitionMode == true {
                diceClicked = true
                if cardArray[cardNode].cardChallengesType != "Truth or Dare" {
                    if cardArray[cardNode].correctPrompt == selectedPrompt {
                        
                        addBuyOfferPopUp(challengeName: "Do you want to acquisition?", buyCost: cardArray[cardNode].cost+20)
                    } else {
                        diceClicked = false
                        wrongAnswerView()
//                        coinReductionView()
                        //ke-skip karena salah jawab prompt
                        //poin berkurang
                    }
                } else {
                    addBuyOfferPopUp(challengeName: "Do you want to acquisition?", buyCost: cardArray[cardNode].cost+20)
                }
            } else {
                diceClicked = false
                let firstPrompt = textField?.text
                cardArray[cardNode].firstPrompt = firstPrompt ?? "Enter your prompt"
                self.countShown = 2
                
                let secondPrompt = textField2?.text
                cardArray[cardNode].secondPrompt = secondPrompt ?? "Enter your prompt"
                self.countShown = 2
                
                let thirdPrompt = textField3?.text
                cardArray[cardNode].thirdPrompt = thirdPrompt ?? "Enter your prompt"
                self.countShown = 2

                cardArray[cardNode].correctPrompt = self.selectedPrompt
            }
            
        } else if circleNode?.contains(touchLocation) == true && popUpContainer2Appeared == true {
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
            
        } else if circleNode2?.contains(touchLocation) == true && popUpContainer2Appeared == true {
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
            
        } else if circleNode3?.contains(touchLocation) == true && popUpContainerAppeared == true {
            thirdCircleClicked.toggle()
            selectedPrompt = "firstPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -12)
            
            lieLabel?.removeFromParent()
            circleNode3?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode3?.addChild(lieLabel!)
            
            circleNode4?.fillColor = UIColor.white
            circleNode5?.fillColor = UIColor.white
            
            fourthCircleClicked = false
            fifthCircleClicked = false
            
        } else if circleNode4?.contains(touchLocation) == true && popUpContainerAppeared == true {
            fourthCircleClicked.toggle()
            selectedPrompt = "secondPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -12)
            
            lieLabel?.removeFromParent()
            circleNode4?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode4?.addChild(lieLabel!)
            
            circleNode3?.fillColor = UIColor.white
            circleNode5?.fillColor = UIColor.white
            
            thirdCircleClicked = false
            fifthCircleClicked = false
            
        } else if circleNode5?.contains(touchLocation) == true && popUpContainerAppeared == true {
            fifthCircleClicked.toggle()
            selectedPrompt = "thirdPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -12)
            
            lieLabel?.removeFromParent()
            circleNode5?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode5?.addChild(lieLabel!)
            
            circleNode3?.fillColor = UIColor.white
            circleNode4?.fillColor = UIColor.white
            
            thirdCircleClicked = false
            fourthCircleClicked = false
            
        } else if dareButtonFrame?.contains(touchLocation) == true && todPopUpAppeared == true {
            removePopUpContainer()
            todPopUpAppeared = false
            addPopUpContainer3(title: "DARE")
            cardArray[cardNode].cardChallenge = "DARE"
            
        } else if truthButtonFrame?.contains(touchLocation) == true && todPopUpAppeared == true {
            removePopUpContainer()
            todPopUpAppeared = false
            addPopUpContainer3(title: "TRUTH")
            cardArray[cardNode].cardChallenge = "TRUTH"
            
        } else if buyButtonFrame?.contains(touchLocation) == true && buyPopUpAppeared == true {
            removePopUpContainer()
            buyPopUpAppeared = false
            buy = true
            
            if onAcquisitionMode == true {
                cardArray[cardNode].cost += 20
                cardArray[cardNode].firstPrompt = ""
                cardArray[cardNode].secondPrompt = ""
                cardArray[cardNode].thirdPrompt = ""
                cardArray[cardNode].correctPrompt = ""
                onAcquisitionMode = false
                
                if challengeName == "2 Truth 1 Lie" {
                    addPopUpContainer()
                } else if challengeName == "Would You Rather" {
                    addPopUpContainer2()
                } else if challengeName == "Truth or Dare" {
                    addTODPopUp()
                }
                
            } else {
                cardArray[cardNode].cost += 20
                cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                playersDataArray[currentPlayerIndexForPopUp].currentPoin -= cardArray[cardNode].cost
                
                for i in 0..<self.playerCoinTextArray.count {
                    self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                }
                
                if challengeName == "2 Truth 1 Lie" {
                    addPopUpContainer()
                } else if challengeName == "Would You Rather" {
                    addPopUpContainer2()
                } else if challengeName == "Truth or Dare" {
                    addTODPopUp()
                }
            }
            
        } else if skipButtonFrame?.contains(touchLocation) == true && (challengePopUpAppeared == true || buyPopUpAppeared == true) {
            diceClicked = false
            challengePopUpAppeared = false
            buyPopUpAppeared = false
            overlayNode?.isHidden = true
            
            if cardArray[cardNode].cardChallengesType == "Challenge" {
                cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                playersDataArray[currentPlayerIndexForPopUp].currentPoin += 50
            }
            
            removePopUpContainer()
            
            buy = false
            
        } else if mainMenuButtonFrame?.contains(touchLocation) == true && leaderboardPopUpAppeared == true {
            //back to main menu
            leaderboardPopUpAppeared = false
            diceClicked = false
            overlayNode?.isHidden = true
            removePopUpContainer()
        }

    }
    
    func textFieldValidation() -> Bool {
        if cardArray[cardNode].cardChallengesType == "2 Truth 1 Lie" {
            if textField?.text == "" || textField2?.text == "" || textField3?.text == "" {
                return false
            }
        } else if cardArray[cardNode].cardChallengesType == "Would You Rather" {
            if textField?.text == "" || textField2?.text == "" {
                return false
            }
        } else {
            if textField?.text == "" {
                return false
            }
        }
        return true
    }
    
    func wrongAnswerView() {
        let wrongAnswer = SKSpriteNode(imageNamed: "wrong_answer")
        wrongAnswer.position = CGPoint(x: 0, y: 0)
        addChild(wrongAnswer)
        
        let waitAction = SKAction.wait(forDuration: 2)
        let removeAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([waitAction, removeAction])
        
        wrongAnswer.run(sequenceAction)
    }
    
    func coinReductionView() {
        let coinReduction = SKSpriteNode(imageNamed: "coin_reduction")
        coinReduction.zPosition = 50
        coinReduction.position = CGPoint(x: 0, y: 0)
        addChild(coinReduction)
        
        let waitAction = SKAction.wait(forDuration: 1.5)
        let removeAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([waitAction, removeAction])
        
        coinReduction.run(sequenceAction)
    }
    
    func coinAdditionView() {
        let coinAddition = SKSpriteNode(imageNamed: "coin_addition")
        coinAddition.zPosition = 50
        coinAddition.position = CGPoint(x: 0, y: 0)
        addChild(coinAddition)
        
        let waitAction = SKAction.wait(forDuration: 1.5)
        let removeAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([waitAction, removeAction])
        
        coinAddition.run(sequenceAction)
    }
    
    func addPopUpContainer() {
        popUpContainerAppeared = true
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 600))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 200
        
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
        buttonLabel?.zPosition = 25
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        textField?.autocorrectionType = .no
        textField?.text = "\(cardArray[cardNode].firstPrompt)"
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField?.leftView = leftPaddingView
        textField?.leftViewMode = .always
        
        circleNode3 = SKShapeNode(circleOfRadius: 40)
        circleNode3?.fillColor = UIColor.white
        circleNode3?.lineWidth = 2
        circleNode3?.position = CGPoint(x: -330, y: 114)
        
        //second text field
        let textField2Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
        textField2 = UITextField(frame: textField2Frame)
        textField2?.backgroundColor = UIColor.white
        textField2?.placeholder = "Enter your prompt"
        textField2?.layer.cornerRadius = textFieldFrame.size.height / 2
        textField2?.autocorrectionType = .no
        textField2?.text = "\(cardArray[cardNode].secondPrompt)"
        
        let leftPadding2View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField2?.leftView = leftPadding2View
        textField2?.leftViewMode = .always
        
        circleNode4 = SKShapeNode(circleOfRadius: 40)
        circleNode4?.fillColor = UIColor.white
        circleNode4?.lineWidth = 2
        circleNode4?.position = CGPoint(x: -330, y: 13)
        
        //third text field
        let textField3Frame = CGRect(origin: CGPoint(x: 0, y: 200), size: CGSize(width: 600, height: 70))
        textField3 = UITextField(frame: textField3Frame)
        textField3?.backgroundColor = UIColor.white
        textField3?.placeholder = "Enter your prompt"
        textField3?.layer.cornerRadius = textFieldFrame.size.height / 2
        textField3?.autocorrectionType = .no
        textField3?.text = "\(cardArray[cardNode].thirdPrompt)"
        
        let leftPadding3View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField3?.leftView = leftPadding3View
        textField3?.leftViewMode = .always
        
        circleNode5 = SKShapeNode(circleOfRadius: 40)
        circleNode5?.fillColor = UIColor.white
        circleNode5?.lineWidth = 2
        circleNode5?.position = CGPoint(x: -330, y: -87)
        
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
        
        thirdCircleClicked.toggle()
        selectedPrompt = "firstPrompt"
        
        //check list label on circle
        lieLabel = SKLabelNode(text: "LIE")
        lieLabel?.fontName = "AvenirNext-Bold"
        lieLabel?.fontColor = .white
        lieLabel?.fontSize = 30
        lieLabel?.position = CGPoint(x: 0, y: -12)
        
        lieLabel?.removeFromParent()
        circleNode3?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        circleNode3?.addChild(lieLabel!)
        
        circleNode4?.fillColor = UIColor.white
        circleNode5?.fillColor = UIColor.white
        
        fourthCircleClicked = false
        fifthCircleClicked = false
        
        addChild(popUpContainer!)
        buttonFrame?.addChild(buttonLabel!)
        popUpContainer?.addChild(buttonFrame!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(circleNode3!)
        popUpContainer?.addChild(circleNode4!)
        popUpContainer?.addChild(circleNode5!)
    }
    
    func addPopUpContainer2() {
        popUpContainer2Appeared = true
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 480))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 200
        
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
        buttonLabel?.zPosition = 25
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        textField?.autocorrectionType = .no
        textField?.text = "\(cardArray[cardNode].firstPrompt)"
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField?.leftView = leftPaddingView
        textField?.leftViewMode = .always
        
        circleNode = SKShapeNode(circleOfRadius: 40)
        circleNode?.fillColor = UIColor.white
        circleNode?.lineWidth = 2
        circleNode?.position = CGPoint(x: -330, y: 64)
        
        //second text field
        let textField2Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
        textField2 = UITextField(frame: textField2Frame)
        textField2?.backgroundColor = UIColor.white
        textField2?.placeholder = "Enter your prompt"
        textField2?.layer.cornerRadius = textFieldFrame.size.height / 2
        textField2?.autocorrectionType = .no
        textField2?.text = "\(cardArray[cardNode].secondPrompt)"
        
        let leftPadding2View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField2?.leftView = leftPadding2View
        textField2?.leftViewMode = .always
        
        circleNode2 = SKShapeNode(circleOfRadius: 40)
        circleNode2?.fillColor = UIColor.white
        circleNode2?.lineWidth = 2
        circleNode2?.position = CGPoint(x: -330, y: -37)
        
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
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(buttonFrame!)
        popUpContainer?.addChild(buttonLabel!)
        popUpContainer?.addChild(circleNode!)
        popUpContainer?.addChild(circleNode2!)
    }
    
    func addPopUpContainer3(title: String) {
        popUpContainer3Appeared = true
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 380))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 200
        
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
        buttonLabel?.zPosition = 25
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: -11), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        textField?.autocorrectionType = .no
        textField?.text = "\(cardArray[cardNode].firstPrompt)"
        
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
    
    func addBuyOfferPopUp(challengeName: String, buyCost: Int) {
        buyPopUpAppeared = true
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 350))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 200
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: onAcquisitionMode ? "ACQUISITION?" : "YOU LANDED ON")
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
        skipButtonLabel?.zPosition = 25
        
        //buy button
        buyButtonFrame = SKShapeNode(rectOf: CGSize(width: 365, height: 85), cornerRadius: 40)
        buyButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buyButtonFrame?.position = CGPoint(x: -160, y: -82)
        
        buyButtonLabel = SKLabelNode(text: "BUY      \(cardArray[cardNode].cost)")
        buyButtonLabel?.fontName = "AvenirNext-Bold"
        buyButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buyButtonLabel?.fontSize = 50
        buyButtonLabel?.position = CGPoint(x: -160, y: -100)
        buyButtonLabel?.zPosition = 25
        
        //coin image for button
        let coinImage = SKSpriteNode(imageNamed: "coin")
        coinImage.position = CGPoint(x: -157, y: -80)
        coinImage.size = CGSize(width: 50, height: 50)
        coinImage.zPosition = 25
        
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
        challengePopUpAppeared = true
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1150, height: 350))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 200
        
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
        subTitleLabel.fontName = "AvenirNext"
        subTitleLabel.fontColor = UIColor.black
        subTitleLabel.fontSize = 25
        subTitleLabel.position = CGPoint(x: 0, y: 40)
        
        //challenge label
        let challengeNameLabel = SKLabelNode(text: challenges.randomElement()?.challengePrompt)
        challengeNameLabel.fontName = "AvenirNext"
        challengeNameLabel.fontColor = UIColor.black
        challengeNameLabel.fontSize = 25
        challengeNameLabel.position = CGPoint(x: 0, y: -15)
        
        //next button
        skipButtonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        skipButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        skipButtonFrame?.position = CGPoint(x: 0, y: -105)
        
        skipButtonLabel = SKLabelNode(text: "DONE")
        skipButtonLabel?.fontName = "AvenirNext-Bold"
        skipButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        skipButtonLabel?.fontSize = 50
        skipButtonLabel?.position = CGPoint(x: 0, y: -125)
        skipButtonLabel?.zPosition = 25
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(subTitleLabel)
        popUpContainer?.addChild(challengeNameLabel)
        popUpContainer?.addChild(skipButtonLabel!)
        popUpContainer?.addChild(skipButtonFrame!)
    }
    
    func addTODPopUp() {
        todPopUpAppeared = true
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 800, height: 200))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 200
        
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
        dareButtonLabel?.zPosition = 25
        
        //buy button
        truthButtonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        truthButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        truthButtonFrame?.position = CGPoint(x: -188, y: 0)
        
        truthButtonLabel = SKLabelNode(text: "TRUTH")
        truthButtonLabel?.fontName = "AvenirNext-Bold"
        truthButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        truthButtonLabel?.fontSize = 50
        truthButtonLabel?.position = CGPoint(x: -188, y: -17)
        truthButtonLabel?.zPosition = 25
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(dareButtonFrame!)
        popUpContainer?.addChild(dareButtonLabel!)
        popUpContainer?.addChild(truthButtonFrame!)
        popUpContainer?.addChild(truthButtonLabel!)
    }
    
    func removePopUpContainer() {
        skView?.removeFromSuperview()
        popUpContainer?.removeAllChildren()
        popUpContainer?.removeFromParent()
        popUpContainer = nil
    }
    
    func addOverlay() {
        overlayNode = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.3), size: self.size)
        overlayNode?.zPosition = -80
        overlayNode?.isHidden = true
        addChild(overlayNode!)
    }
    
    func addLeaderboardPopUp() {
        leaderboardPopUpAppeared = true
        
        let sortedPlayers = playersDataArray.sorted { $0.currentPoin > $1.currentPoin }
        
        let firstPlaceImage: SKSpriteNode?
        let secondPlaceImage: SKSpriteNode?
        let thirdPlaceImage: SKSpriteNode?
        let fourthPlaceImage: SKSpriteNode?
        
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 840, height: 650))
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
        let titleLabel = SKLabelNode(text: "PLAYERS RANK")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 235)
        
        //next button
        mainMenuButtonFrame = SKShapeNode(rectOf: CGSize(width: 450, height: 85), cornerRadius: 40)
        mainMenuButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        mainMenuButtonFrame?.position = CGPoint(x: 0, y: -225)
        
        mainMenuButtonLabel = SKLabelNode(text: "PLAY AGAIN")
        mainMenuButtonLabel?.fontName = "AvenirNext-Bold"
        mainMenuButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        mainMenuButtonLabel?.fontSize = 50
        mainMenuButtonLabel?.position = CGPoint(x: 0, y: -241)
        
        //leaderboard image
        let leaderboardImage = SKSpriteNode(imageNamed: "Leaderboard")
        leaderboardImage.position = CGPoint(x: 0, y: -10)
        leaderboardImage.zPosition = 10
        
        //set player images
        firstPlaceImage = SKSpriteNode(imageNamed: "player1leaderboard")
        firstPlaceImage?.position = CGPoint(x: 54, y: 155)
        
        secondPlaceImage = SKSpriteNode(imageNamed: "player2leaderboard")
        secondPlaceImage?.position = CGPoint(x: -90, y: 110)
        
        thirdPlaceImage = SKSpriteNode(imageNamed: "player4leaderboard")
        thirdPlaceImage?.position = CGPoint(x: 207, y: 45)
        
        fourthPlaceImage = SKSpriteNode(imageNamed: "player3leaderboard")
        fourthPlaceImage?.position = CGPoint(x: -222, y: -15)
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(firstPlaceImage!)
        popUpContainer?.addChild(secondPlaceImage!)
        popUpContainer?.addChild(thirdPlaceImage!)
        popUpContainer?.addChild(fourthPlaceImage!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(mainMenuButtonLabel!)
        popUpContainer?.addChild(mainMenuButtonFrame!)
        popUpContainer?.addChild(leaderboardImage)
    }
    
    override func didEvaluateActions() {
        let objPosition = myObject.objPosition
        
        for i in 0..<playersDataArray.count {
            if playersDataArray[i].currentPoin < 0 {
                // SOMEONE LOSES - GAME SELESAI
                addLeaderboardPopUp()
            }
        }
        
        
        if currentPlayerIndex != 0 {
            currentPlayerIndexForPopUp = currentPlayerIndex - 1
        }
        else {
            currentPlayerIndexForPopUp = playersDataArray.count - 1
        }
        
        for i in 0...24 {
            if boardNodes[i].position == objPosition {
                cardNode = i
            }
        }
        
        if (buyPopUpAppeared == true || popUpContainerAppeared == true || popUpContainer2Appeared == true || popUpContainer3Appeared == true || challengePopUpAppeared == true || todPopUpAppeared == true || leaderboardPopUpAppeared == true) {
            overlayNode?.isHidden = false
        }
        
        if cardArray[cardNode].cardChallengesType == "2 Truth 1 Lie" && countShown == 0 {
            
            challengeName = "2 Truth 1 Lie"

            if cardArray[cardNode].cardOwner != playersDataArray[currentPlayerIndexForPopUp].playersName {
                if cardArray[cardNode].cardOwner == "Null" {
                    onAcquisitionMode = false
                    delay(2) {
                        self.addBuyOfferPopUp(challengeName: self.challengeName, buyCost: 150)
                    }
                } else {
                    for i in 0...playersDataArray.count - 1 {
                        if cardArray[cardNode].cardOwner == playersDataArray[i].playersName {
                            lastOwnerIndex = i
                            
                        }
                    }
                    cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                    playersDataArray[currentPlayerIndexForPopUp].currentPoin -= cardArray[cardNode].cost+20 //check lagi ngurangin berapa di rules
                    playersDataArray[lastOwnerIndex].currentPoin += cardArray[cardNode].cost+20
                    for i in 0..<self.playerCoinTextArray.count {
                        self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                    }
                    onAcquisitionMode = true
                    delay(2) {
                        self.addPopUpContainer()
                    }
                }
            }
            countShown = 1
            
        } else if cardArray[cardNode].cardChallengesType == "Would You Rather" && countShown == 0 {
            
            challengeName = "Would You Rather"
            
            if cardArray[cardNode].cardOwner != playersDataArray[currentPlayerIndexForPopUp].playersName {
                if cardArray[cardNode].cardOwner == "Null" {
                    onAcquisitionMode = false
                    delay(2) {
                        self.addBuyOfferPopUp(challengeName: self.challengeName, buyCost: 120)
                    }
                    
                } else {
                    for i in 0...playersDataArray.count - 1 {
                        if cardArray[cardNode].cardOwner == playersDataArray[i].playersName {
                            lastOwnerIndex = i
                            
                        }
                    }
                    cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                    playersDataArray[currentPlayerIndexForPopUp].currentPoin -= cardArray[cardNode].cost+20 //check lagi ngurangin berapa di rules
                    playersDataArray[lastOwnerIndex].currentPoin += cardArray[cardNode].cost+20
                    for i in 0..<self.playerCoinTextArray.count {
                        self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                    }
                    onAcquisitionMode = true
                    delay(2) {
                        self.addPopUpContainer2()
                    }
                }
            }
            countShown = 1
            
        } else if cardArray[cardNode].cardChallengesType == "Truth or Dare" && countShown == 0 {
            
            challengeName = "Truth or Dare"
            
            if cardArray[cardNode].cardOwner != playersDataArray[currentPlayerIndexForPopUp].playersName {
                if cardArray[cardNode].cardOwner == "Null" {
                    onAcquisitionMode = false
                    delay(2) {
                        self.addBuyOfferPopUp(challengeName: self.challengeName, buyCost: 150)
                    }
                } else {
                    for i in 0...playersDataArray.count - 1 {
                        if cardArray[cardNode].cardOwner == playersDataArray[i].playersName {
                            lastOwnerIndex = i
                            
                        }
                    }
                    cardArray[cardNode].cardOwner = playersDataArray[currentPlayerIndexForPopUp].playersName
                    playersDataArray[currentPlayerIndexForPopUp].currentPoin -= cardArray[cardNode].cost+20 //check lagi ngurangin berapa di rules
                    playersDataArray[lastOwnerIndex].currentPoin += cardArray[cardNode].cost+20
                    for i in 0..<self.playerCoinTextArray.count {
                        self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
                    }
                    onAcquisitionMode = true
                    if cardArray[cardNode].cardChallenge == "DARE" {
                        delay(2) {
                            self.addPopUpContainer3(title: "DARE")
                        }
                    } else {
                        delay(2) {
                            self.addPopUpContainer3(title: "TRUTH")
                        }
                    }
                    
                }
            }
                
            countShown = 1
            
        } else if cardArray[cardNode].cardChallengesType == "Challenge" && countShown == 0 {
            
            playersDataArray[currentPlayerIndexForPopUp].currentPoin += 50 //check lagi ngurangin berapa di rules
            for i in 0..<self.playerCoinTextArray.count {
                self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
            }
            
            challengeName = "Challenge"
            addChallengePopUp()   //challenge
            countShown = 1
            
        } else if cardArray[cardNode].cardChallengesType == "Safe House" && countShown == 0 {
            
            challengeName = "Safe House"
            print("Safe House!")
            diceClicked = false
            
            playersDataArray[currentPlayerIndexForPopUp].currentPoin = Int(Double(playersDataArray[currentPlayerIndexForPopUp].currentPoin) + Double(playersDataArray[currentPlayerIndexForPopUp].currentPoin) * 0.1)
            
            for i in 0..<self.playerCoinTextArray.count {
                self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
            }
            
            countShown = 1
            
        } else if cardArray[cardNode].cardChallengesType == "Force Move" && countShown == 0 {
            
            challengeName = "Force Move"
            diceClicked = false
            print("Force Move!")
            
            let randomPosition = Int.random(in: 0...24)
            let randomPlayer = Int.random(in: 0..<playersDataArray.count)
            movePiece(playersDataArray[randomPlayer].pieceNode, toTile: randomPosition)
            playersDataArray[randomPlayer].currentSteps=randomPosition
            print("force move player \(playersDataArray[randomPlayer].playersName) ke board \(randomPosition)")
            countShown = 1
            
        } else if cardArray[cardNode].cardChallengesType == "LG" && countShown == 0 {
            
            challengeName = "Let Go"
            diceClicked = false
            print("Let Go!")
            
            playersDataArray[currentPlayerIndexForPopUp].currentPoin = Int(Double(playersDataArray[currentPlayerIndexForPopUp].currentPoin) - Double(playersDataArray[currentPlayerIndexForPopUp].currentPoin) * 0.1)
            
            for i in 0..<self.playerCoinTextArray.count {
                self.playerCoinTextArray[i].text = "\(playersDataArray[i].currentPoin)"
            }
            
            countShown = 1
            
        } else if cardArray[cardNode].cardChallengesType == "Start" && countShown == 0 {
            
            challengeName = "Start"
            diceClicked = false
            for i in 0...playersDataArray.count-1{
                self.movePiece(playersDataArray[1].pieceNode, toTile: 0)
                playersDataArray[i].currentSteps=0
            }
            print("Start!")
            if cameraCount == true {
                presentSwiftUIView()
            }
            
            
            countShown = 1
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
