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
    
    override func didMove(to view: SKView) {
        initalize();
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackgroundsAndGrounds();
    }
    
    func initalize() {
        createBird()
        createBackgrounds();
        createGrounds();
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
}
