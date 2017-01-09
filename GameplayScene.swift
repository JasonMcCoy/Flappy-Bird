//
//  GameplayScene.swift
//  FlappyBirdClone
//
//  Created by Deborah on 1/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
    override func didMove(to view: SKView) {
        initalize();
    }
    
    func initalize() {
        createBackgrounds();
        createGrounds();
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
}
