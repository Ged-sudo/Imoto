import SpriteKit

class MainMenu: SKScene {
    
    var menuPersDown: SKSpriteNode!
    var startButton: SKSpriteNode!
    var nameGameLabel: SKLabelNode!
    var backImg: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        startButton = SKSpriteNode(imageNamed: "startButton")
        startButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height * 0.8)
        startButton.size.width = self.frame.width * 0.66
        startButton.size.height = self.frame.height / 3
        self.addChild(startButton)
        
        nameGameLabel = SKLabelNode(text: "Imoto chan <3")
        nameGameLabel.position = CGPoint(x: self.frame.width / 2, y: (self.frame.height * 0.85))
        nameGameLabel.fontName = "Blood"
        nameGameLabel.fontSize = 50
        //self.addChild(nameGameLabel)
        
        menuPersDown = SKSpriteNode(imageNamed: "animeGirl")
        menuPersDown.position = CGPoint(x: self.frame.width / 2, y: (self.frame.height * 0.3))
        //menuPersDown.setScale(3)
        self.addChild(menuPersDown)
        
        backImg = SKSpriteNode(imageNamed: "backImg")
        backImg.zPosition = -10
        backImg.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        backImg.setScale(1.6)
        self.addChild(backImg)
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
           let location = touch.location(in: self)
            if startButton.contains(location) {
                let transit = SKTransition.flipVertical(withDuration: 0.5)
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                self.view?.presentScene(gameScene, transition: transit)
            }
        }
    }


}
