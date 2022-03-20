import SpriteKit
import GameplayKit
import UIKit
import CoreData

class GameScene: SKScene {
    
    var timeLastDo: Double = 0
    
    var hungry: Int = UserDefaults.standard.integer(forKey: "hungry")
    var attantion: Int = UserDefaults.standard.integer(forKey: "attantion")
    var angry: Int = UserDefaults.standard.integer(forKey: "angry")
    
    var persImage: SKSpriteNode!
    var messagePers: SKLabelNode!
    var imgMess: SKSpriteNode!
    var menuButton: SKSpriteNode!
    var happyLabel: SKLabelNode!
    var happyPoint: Int = 0
    
    var minesHappyPoint: Timer!
    var hugButton: SKSpriteNode!
    var kissButton: SKSpriteNode!
    var voiceButton: SKSpriteNode!
    var eatButton: SKSpriteNode!
    var kawaiButton: SKSpriteNode!
    var backImg: SKSpriteNode!
    
    var flagKawai: Bool = true
    var canKawai: Timer!
    var eatFlag: Bool = true
    var eatTimer: Timer!
    var kissFlag: Bool = true
    var kissTimer: Timer!
    var voiceFlag: Bool = true
    var voiceTimer: Timer!
    var hugFlag: Bool = true
    var hugTimer: Timer!
    
    override func didMove(to view: SKView) {
        
        let timeinterval = 60.0 * 60.0
        let timeNow: Double = Double(NSDate().timeIntervalSince1970)
        var deltaTime = timeNow - UserDefaults.standard.double(forKey: "lastTimeDo")
        deltaTime = (deltaTime / timeinterval) / 3600 / 24 / 365
        if UserDefaults.standard.integer(forKey: "attantion") != 25 && UserDefaults.standard.integer(forKey: "hungry") != 25 && UserDefaults.standard.integer(forKey: "angry") != 0{
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey:"angry") + Int(deltaTime), forKey: "angry")
            UserDefaults.standard.set(UserDefaults.standard.double(forKey:"hungry") - (3 * Double(deltaTime)), forKey: "hungry")
            UserDefaults.standard.set(UserDefaults.standard.double(forKey:"attantion") - (5 * Double(deltaTime)), forKey: "attantion")
        }
        
        print("Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))")
        print("--------Game------------")
        print(UserDefaults.standard.integer(forKey: "attantion"))
        print(UserDefaults.standard.integer(forKey: "hungry"))
        print(UserDefaults.standard.integer(forKey: "angry"))
        print(deltaTime)
        print("--------Game------------")
        
       // ------------------------------------------------------------------------
        
        
        happyLabel = SKLabelNode(text: "Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))")
        happyLabel.position = CGPoint(x: self.frame.width / 2, y: 0.87 * self.frame.height)
        happyLabel.fontName = "Blood"
        self.addChild(happyLabel)
        
        persImage = SKSpriteNode(imageNamed: "animeGirl")
        persImage.position = CGPoint(x: self.frame.width / 3.5, y: self.frame.height / 3.5)
        persImage.setScale(0.75)
        self.addChild(persImage)
        
        backImg = SKSpriteNode(imageNamed: "backImg")
        backImg.position = CGPoint(x: self.frame.width , y: self.frame.height / 2)
        backImg.zPosition = -10
        backImg.setScale(1.15)
        self.addChild(backImg)
        
        
        messagePers = SKLabelNode(text: "Привет!")
        messagePers.position = CGPoint(x: self.frame.width / 3.5, y: self.frame.height * 0.7)
        messagePers.fontName = "Blood"
        self.addChild(messagePers)
        
        imgMess = SKSpriteNode(imageNamed: "chat")
        imgMess.position = CGPoint(x: self.frame.width / 3.5, y: self.frame.height * 0.7)
        imgMess.zPosition = -8
        imgMess.setScale(0.4)
        self.addChild(imgMess)
        
        hugButton = SKSpriteNode(imageNamed: "hug")
        hugButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 7 * (self.frame.height / 8))
        hugButton.setScale(0.13)
        self.addChild(hugButton)
        
        kissButton = SKSpriteNode(imageNamed: "kiss")
        kissButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 4 * (self.frame.height / 8))
        kissButton.setScale(0.13)
        self.addChild(kissButton)
        
        voiceButton = SKSpriteNode(imageNamed: "voiceKawai")
        voiceButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 5 * (self.frame.height / 8))
        voiceButton.setScale(0.13)
        self.addChild(voiceButton)
        
        eatButton = SKSpriteNode(imageNamed: "eat")
        eatButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 6 * (self.frame.height / 8))
        eatButton.setScale(0.13)
        self.addChild(eatButton)
        
        kawaiButton = SKSpriteNode(imageNamed: "heart")
        kawaiButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 3 * (self.frame.height / 8))
        kawaiButton.setScale(0.13)
        self.addChild(kawaiButton)
        
        menuButton = SKSpriteNode(imageNamed: "menu")
        menuButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 50)
        menuButton.setScale(0.5)
        self.addChild(menuButton)
        
        minesHappyPoint = Timer.scheduledTimer(timeInterval: timeinterval, target: self, selector: #selector(minusHappyPoint), userInfo: nil, repeats: true)
    }
    
    //---------------отслеживание-нажатий-на-кнопки---------------------------------------------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
           let location = touch.location(in: self)
            if menuButton.contains(location) {
                let transit = SKTransition.flipVertical(withDuration: 0.5)
                let gameScene = MainMenu(size: UIScreen.main.bounds.size)
                
                self.view?.presentScene(gameScene, transition: transit)
            }
            
            if kawaiButton.contains(location){
                kawai()
                let timeNow: Double = Double(NSDate().timeIntervalSince1970)
                timeLastDo = Double(Int(timeNow))
                UserDefaults.standard.set(timeLastDo, forKey: "timeLastDo")
            }
            
            if eatButton.contains(location){
                eat()
                let timeNow: Double = Double(NSDate().timeIntervalSince1970)
                timeLastDo = Double(Int(timeNow))
                UserDefaults.standard.set(timeLastDo, forKey: "timeLastDo")
            }
            
            if voiceButton.contains(location){
                voiceKawai()
                let timeNow: Double = Double(NSDate().timeIntervalSince1970)
                timeLastDo = Double(Int(timeNow))
                UserDefaults.standard.set(timeLastDo, forKey: "timeLastDo")
            }
        
            if kissButton.contains(location){
                kiss()
                let timeNow: Double = Double(NSDate().timeIntervalSince1970)
                timeLastDo = Double(Int(timeNow))
                UserDefaults.standard.set(timeLastDo, forKey: "timeLastDo")
            }
    
            if hugButton.contains(location){
                hug()
                let timeNow: Double = Double(NSDate().timeIntervalSince1970)
                timeLastDo = Double(Int(timeNow))
                UserDefaults.standard.set(timeLastDo, forKey: "timeLastDo")
            }
            if persImage.contains(location){
                figth()
                let timeNow: Double = Double(NSDate().timeIntervalSince1970)
                timeLastDo = Double(Int(timeNow))
                UserDefaults.standard.set(timeLastDo, forKey: "timeLastDo")
                //print(timeLastDo)
            }
        }
    }
    
    //---------------отработка-нажатий-на-кнопки---------------------------------------------------
    
    func kawai(){
        if flagKawai{
            flagKawai = false
            
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "attantion") + 1, forKey: "attantion")
            
            let messageChoice = ["Как мило!","Мммм...","Хи-хи!","Няя"]
            let message = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: messageChoice) as! [String]
            messagePers.text = message[0]
            if message[0] == "Как мило!"{
                self.run(SKAction.playSoundFileNamed("SoSweetVoice.mp3", waitForCompletion: false))
            }
            if message[0] == "Мммм..."{
                self.run(SKAction.playSoundFileNamed("Mmm...Voice.mp3", waitForCompletion: false))
            }
            if message[0] == "Хи-хи!"{
                self.run(SKAction.playSoundFileNamed("HiHiVoice.mp3", waitForCompletion: false))
            }
            if message[0] == "Няя"{
                self.run(SKAction.playSoundFileNamed("NyaaVoice.mp3", waitForCompletion: false))
            }
            
            kawaiButton.removeFromParent()
            
            kawaiButton = SKSpriteNode(imageNamed: "heartImgTouched")
            kawaiButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 3 * (self.frame.height / 8))
            kawaiButton.setScale(0.1)
            self.addChild(kawaiButton)
            
            
            let timeinterval = 25
            
            canKawai = Timer.scheduledTimer(timeInterval: TimeInterval(timeinterval), target: self, selector: #selector(changeFlag), userInfo: nil, repeats: false)
            
            happyLabel.text = "Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))"
            
        }else{
            messagePers.text = "Потоом)"
        }
        
    }
    
    func eat(){
        
        if eatFlag{
            eatFlag = false
            
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "hungry") + 2, forKey: "hungry")
          
            let messageOppinion = ["Вкусно!","Спасибо!","Вааай!","Обкушалася.."]
            let message = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: messageOppinion) as! [String]
            messagePers.text = message[0]
            let nameVoice = "eat.mp3"
            self.run(SKAction.playSoundFileNamed(nameVoice, waitForCompletion: false))
            let timeinterval = 10
            eatTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeinterval), target: self,selector: #selector(changeEatFlag), userInfo: nil, repeats: false)
            
            eatButton.removeFromParent()
            
            eatButton = SKSpriteNode(imageNamed: "eatImgTouched")
            eatButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 6 * (self.frame.height / 8))
            eatButton.setScale(0.1)
            self.addChild(eatButton)
            
            happyLabel.text = "Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))"
            
        }else{
            messagePers.text = "Я сыыытаая)"
        }
    }
    
    func voiceKawai(){
        if voiceFlag{
            voiceFlag = false
            
            let messageOppinion = ["kawaiVoice1.mp3","kawaiVoice2.mp3","kawaiVoice3.mp3","kawaiVoice4.mp3"]
            let message = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: messageOppinion) as! [String]
          
            let nameVoice = message[0]
            self.run(SKAction.playSoundFileNamed(nameVoice, waitForCompletion: false))
            let timeinterval = 3
            voiceTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeinterval), target: self,selector: #selector(changeVoiceFlag), userInfo: nil, repeats: false)
            
            voiceButton.removeFromParent()
            
            voiceButton = SKSpriteNode(imageNamed: "voiceImgTouched")
            voiceButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 5 * (self.frame.height / 8))
            voiceButton.setScale(0.1)
            self.addChild(voiceButton)
            
            happyLabel.text = "Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))"
        }else{
            messagePers.text = "ну ээй"
        }
    }
    
    func kiss(){
        
        if kissFlag{
            
            kissFlag = false
            
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "attantion") + 4, forKey: "attantion")
            
            let nameVoice = "kissVoice.mp3"
            self.run(SKAction.playSoundFileNamed(nameVoice, waitForCompletion: false))
            let timeinterval = 10
            eatTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeinterval), target: self,selector: #selector(changeKissFlag), userInfo: nil, repeats: false)
            
            messagePers.text = "Тьмок <3"
            
            kissButton.removeFromParent()
            
            kissButton = SKSpriteNode(imageNamed: "kissImgTouched")
            kissButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 4 * (self.frame.height / 8))
            kissButton.setScale(0.1)
            self.addChild(kissButton)
            
            happyLabel.text = "Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))"
            
        }else{
            messagePers.text = "ой, подожди"
        }
        
    }
    
    func hug(){
        if hugFlag{
            hugFlag = false
            
            
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "attantion") + 3, forKey: "attantion")
            let nameVoice = "hugVoice.mp3"
            self.run(SKAction.playSoundFileNamed(nameVoice, waitForCompletion: false))
            let timeinterval = 10
            hugTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timeinterval), target: self,selector: #selector(changeHugFlag), userInfo: nil, repeats: false)
            
            persImage.removeFromParent()
            persImage = SKSpriteNode(imageNamed: "")
            
            hugButton.removeFromParent()
            
            hugButton = SKSpriteNode(imageNamed: "hugImgTouched")
            hugButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 7 * (self.frame.height / 8))
            hugButton.setScale(0.1)
            self.addChild(hugButton)
            
            happyLabel.text = "Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))"
            
        }else{
            messagePers.text = "ой, подожди"
        }
        
    }
    
    
    
    func figth(){
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "angry") + 10, forKey: "angry")
        happyLabel.text = "Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))"
        
        messagePers.text = "Ай! Больно!"
        
        self.run(SKAction.playSoundFileNamed("suffer.mp3", waitForCompletion: false))
    }
    
    
    
   
    //---------------изменение-флагов-и-вернуть-кнопки-к-прежнему-виду----------------------------------
    
    @objc func minusHappyPoint(){
        
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "angry") + 1, forKey: "angry")
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "hungry") - 3, forKey: "hungry")
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "attantion") - 5, forKey: "attantion")
        
        happyLabel.text = "Уровень счастья: \(UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"))"
        
        print("--------Game------------")
        print(UserDefaults.standard.integer(forKey: "attantion"))
        print(UserDefaults.standard.integer(forKey: "hungry"))
        print(UserDefaults.standard.integer(forKey: "angry"))
        //print(deltaTime)
        print("--------Game------------")
    }
    
    func setImageGirl(){
        var nameImageGirl = "animeGirl"
        
        persImage.removeFromParent()
        
        if (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry") < 100{
        nameImageGirl = "animeGirl"
        }
        if (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry") < 150 && 100 <= (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"){
        nameImageGirl = "animeGirl2"
        }
        if (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry") < 200 && 150 <= (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"){
        nameImageGirl = "animeGirl3"
        }
        if (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry") < 250 && 200 <= (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"){
        nameImageGirl = "animeGirl4"
        }
        if (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry") < 300 && 250 <= (UserDefaults.standard.integer(forKey: "attantion")) + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry"){
        nameImageGirl = "animeGirl5"
        }
        persImage = SKSpriteNode(imageNamed: nameImageGirl)
        persImage.position = CGPoint(x: self.frame.width / 3.5, y: self.frame.height / 3.5)
        persImage.setScale(0.75)
        self.addChild(persImage)
    }
    
    @objc func changeFlag(){
        flagKawai = true
        
        setImageGirl()
        
        kawaiButton.removeFromParent()
        kawaiButton = SKSpriteNode(imageNamed: "heart")
        kawaiButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 3 * (self.frame.height / 8))
        kawaiButton.setScale(0.13)
        self.addChild(kawaiButton)
        
    }
    
    @objc func changeEatFlag(){
        eatFlag = true
        
        setImageGirl()
        
        eatButton.removeFromParent()
        eatButton = SKSpriteNode(imageNamed: "eat")
        eatButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 6 * (self.frame.height / 8))
        eatButton.setScale(0.13)
        self.addChild(eatButton)
        
    }
    
    @objc func changeKissFlag(){
        kissFlag = true
        
        setImageGirl()
        
        kissButton.removeFromParent()
        kissButton = SKSpriteNode(imageNamed: "kiss")
        kissButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 4 * (self.frame.height / 8))
        kissButton.setScale(0.13)
        self.addChild(kissButton)
    }
    
    @objc func changeVoiceFlag(){
        voiceFlag = true
        
        setImageGirl()
        
        voiceButton.removeFromParent()
        voiceButton = SKSpriteNode(imageNamed: "voiceKawai")
        voiceButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 5 * (self.frame.height / 8))
        voiceButton.setScale(0.13)
        self.addChild(voiceButton)
    }
    
    @objc func changeHugFlag(){
        hugFlag = true
        
        setImageGirl()
        
        hugButton.removeFromParent()
        hugButton = SKSpriteNode(imageNamed: "hug")
        hugButton.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 7 * (self.frame.height / 8))
        hugButton.setScale(0.13)
        self.addChild(hugButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (UserDefaults.standard.integer(forKey: "attantion") + UserDefaults.standard.integer(forKey: "hungry") - UserDefaults.standard.integer(forKey: "angry")) <= 0{
            let transit = SKTransition.flipVertical(withDuration: 0.5)
            let gameScene = LooseScene(size: UIScreen.main.bounds.size)
            
            self.view?.presentScene(gameScene, transition: transit)
        }
    }
}
