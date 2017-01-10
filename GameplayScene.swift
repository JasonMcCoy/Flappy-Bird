//
//  GameplayScene.swift
//  FlappyBirdClone
//
//  Created by Deborah on 1/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = Bird();
    
    var pipesHolder = SKNode();
    
    var scoreLabel = SKLabelNode(fontNamed: "04b_19");
    
    var score = 0;
    
    override func didMove(to view: SKView) {
        initalize();
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackgroundsAndGrounds();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.flap();
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Bird" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Bird" && secondBody.node?.name == "Score" {
            incrementScore();
            
        } else if firstBody.node?.name == "Bird" && secondBody.node?.name == "Pipe" {
            
            
        } else if firstBody.node?.name == "Bird" && secondBody.node?.name == "Ground" {
            
        }
    }
    
    func initalize() {
        
        physicsWorld.contactDelegate = self;
        
        createBird()
        createBackgrounds();
        createGrounds();
        spawnObstacles();
        createLabel();
        
    }
    
    func createBird() {
        bird = Bird(imageNamed: "Blue 1");
        bird.initalize();
        bird.position = CGPoint(x: -50, y: 0);
        self.addChild(bird);
    }
    
    func createBackgrounds() {
        for i in 0...2 {
        let bg = SKSpriteNode(imageNamed: "BG Day");
        bg.name = "BG";
        bg.zPosition = 0;
        bg.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 0);
        self.addChild(bg);
            
        }
    }
    
    func createGrounds() {
        for i in 0...2 {
        let ground = SKSpriteNode(imageNamed: "Ground");
        ground.name = "Ground";
        ground.zPosition = 4;
        ground.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        ground.position = CGPoint(x: CGFloat(i) * ground.size.width, y: -(self.frame.size.height / 2));
        self.addChild(ground);
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size);
        ground.physicsBody?.affectedByGravity = false;
        ground.physicsBody?.isDynamic = false;
        ground.physicsBody?.categoryBitMask = ColliderType.Ground;
       // ground.physicsBody?.collisionBitMask = ColliderType.Bird;
       // ground.physicsBody?.contactTestBitMask = ColliderType.Bird;
        }
    }
    
    func moveBackgroundsAndGrounds() {
        enumerateChildNodes(withName: "BG", using: ({
            (node, error) in
            
            node.position.x -= 4.5;
            if node.position.x < -(self.frame.width) {
            node.position.x += self.frame.width * 3;
            }
        }));
        
    func moveBackgroundsAndGrounds() {
        enumerateChildNodes(withName: "Ground", using: ({
        (node, error) in
                
            node.position.x -= 2;
            if node.position.x < -(self.frame.width) {
            node.position.x += self.frame.width * 3;
                }
            }));
    }
        
    }
    
    func createPipes() {
        pipesHolder = SKNode();
        pipesHolder.name = "Holder";
        
        let pipeUp = SKSpriteNode(imageNamed: "Pipe 1");
        let pipeDown = SKSpriteNode(imageNamed: "Pipe 1");
        
        let scoreNode = SKSpriteNode();
        
        scoreNode.color = SKColor.red;
        
        scoreNode.name = "Score";
        scoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        scoreNode.position = CGPoint(x: 0, y: 0);
        scoreNode.size = CGSize(width: 5, height: 300);
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size);
        scoreNode.physicsBody?.categoryBitMask = ColliderType.Score;
        scoreNode.physicsBody?.collisionBitMask = 0;
        scoreNode.physicsBody?.affectedByGravity = false;
        scoreNode.physicsBody?.isDynamic = false;
        
        
        pipeUp.name = "Pipe";
        pipeUp.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pipeUp.position = CGPoint(x: 0, y: 630);
        pipeUp.yScale = 1.5;
        pipeUp.zRotation = CGFloat(M_PI);
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size);
        pipeUp.physicsBody?.categoryBitMask = ColliderType.Pipes;
        pipeUp.physicsBody?.affectedByGravity = false;
        pipeUp.physicsBody?.isDynamic = false;
        
        pipeDown.name = "Pipe";
        pipeDown.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pipeDown.position = CGPoint(x: 0, y: -630);
        pipeDown.yScale = 1.5;
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeDown.size);
        pipeDown.physicsBody?.categoryBitMask = ColliderType.Pipes;
        pipeDown.physicsBody?.affectedByGravity = false;
        pipeDown.physicsBody?.isDynamic = false;
        
        pipesHolder.zPosition = 5;
        pipesHolder.position.x = self.frame.width + 100;
        pipesHolder.position.y = CGFloat.randomBetweenNumbers(firstNum: -300, secondNum: 300);
        //pipesHolder.position = CGPoint(x: 300, y: 0);
        
        pipesHolder.addChild(pipeUp);
        pipesHolder.addChild(pipeDown);
        pipesHolder.addChild(scoreNode);
        
        self.addChild(pipesHolder);
        
        let destination = self.frame.width * 2;
        let move = SKAction.moveTo(x: -destination, duration: TimeInterval(10));
        let remove = SKAction.removeFromParent();
        
        pipesHolder.run(SKAction.sequence([move, remove]), withKey: "Move");
        
    }
    
    func spawnObstacles() {
        let spawn = SKAction.run({ () -> Void in
            self.createPipes();
        });
        
        let delay = SKAction.wait(forDuration: TimeInterval(2));
        let sequence = SKAction.sequence([spawn, delay]);
        
        self.run(SKAction.repeatForever(sequence), withKey: "Spawn");
        
    }
    
    func createLabel() {
        scoreLabel.zPosition = 6;
        scoreLabel.position = CGPoint(x: 0, y: 450);
        scoreLabel.fontSize = 120;
        scoreLabel.text = "0";
        self.addChild(scoreLabel);
    }
    
    func incrementScore() {
        score += 1;
        scoreLabel.text = String(score);
    }
}


