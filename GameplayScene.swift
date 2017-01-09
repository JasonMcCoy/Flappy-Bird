//
//  GameplayScene.swift
//  FlappyBirdClone
//
//  Created by Deborah on 1/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    var bird = Bird();
    
    var pipesHolder = SKNode();
    
    override func didMove(to view: SKView) {
        initalize();
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackgroundsAndGrounds();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.flap();
    }
    
    func initalize() {
        createBird()
        createBackgrounds();
        createGrounds();
        spawnObstacles();
        
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
        
        pipeUp.name = "Pipe";
        pipeUp.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pipeUp.position = CGPoint(x: 0, y: 500);
        pipeUp.zRotation = CGFloat(M_PI);
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size);
        pipeUp.physicsBody?.categoryBitMask = ColliderType.Pipes;
        pipeUp.physicsBody?.affectedByGravity = false;
        pipeUp.physicsBody?.isDynamic = false;
        
        pipeDown.name = "Pipe";
        pipeDown.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pipeDown.position = CGPoint(x: 0, y: -500);
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeDown.size);
        pipeDown.physicsBody?.categoryBitMask = ColliderType.Pipes;
        pipeDown.physicsBody?.affectedByGravity = false;
        pipeDown.physicsBody?.isDynamic = false;
        
        pipesHolder.zPosition = 5;
        pipesHolder.position.x = self.frame.width + 100;
        pipesHolder.position.y = 0;
        pipesHolder.position = CGPoint(x: 300, y: 0);
        
        pipesHolder.addChild(pipeUp);
        pipesHolder.addChild(pipeDown);
        
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
}
