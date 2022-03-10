
import SpriteKit

class LooseScene: SKScene {
    
    var endGame: SKSpriteNode!
    var endGameLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        endGame = SKSpriteNode(imageNamed: "endGameImg")
        endGame.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        self.addChild(endGame)
        
        endGameLabel = SKLabelNode(text: "Вы не уследили за милашкой(")
        endGameLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height * 0.75 )
        self.addChild(endGameLabel)
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
