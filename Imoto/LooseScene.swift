
import SpriteKit

class LooseScene: SKScene {
    
    var endGame: SKSpriteNode!
    var endGameLabel: SKLabelNode!
    var backgroungImg: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        endGame = SKSpriteNode(imageNamed: "restartImg")
        endGame.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        endGame.setScale(0.6)
        self.addChild(endGame)
        
        endGameLabel = SKLabelNode(text: "Очки счастья ниже нуля.")
        endGameLabel.fontName = "Blood"
        endGameLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height * 0.75 )
        endGameLabel.fontSize = 40
        self.addChild(endGameLabel)
        
        backgroungImg = SKSpriteNode(imageNamed: "backImg")
        backgroungImg.position = CGPoint(x: self.frame.width , y: self.frame.height / 2)
        backgroungImg.zPosition = -10
        backgroungImg.setScale(1.8)
        self.addChild(backgroungImg)
        
        UserDefaults.standard.set(25.0, forKey: "hungry")
        UserDefaults.standard.set(25.0, forKey: "attantion")
        UserDefaults.standard.set(0.0, forKey: "angry")
        
        print("--------LOOSE------------")
        print(UserDefaults.standard.integer(forKey: "attantion"))
        print(UserDefaults.standard.integer(forKey: "hungry"))
        print(UserDefaults.standard.integer(forKey: "angry"))
        print("--------LOOSE------------")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
           let location = touch.location(in: self)
            if endGame.contains(location) {
                let transit = SKTransition.flipVertical(withDuration: 0.5)
                let gameScene = MainMenu(size: UIScreen.main.bounds.size)
                
                self.view?.presentScene(gameScene, transition: transit)
            }
        }
    }
    
    
    
}
