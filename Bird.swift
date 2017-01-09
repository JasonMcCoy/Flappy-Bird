//
//  Bird.swift
//  FlappyBirdClone
//
//  Created by Deborah on 1/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import SpriteKit

class Bird: SKSpriteNode {
    
    func initalize() {
        //We will create animations, etc
        
        self.name = "Bird";
        self.zPosition = 3;
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
    }
}
