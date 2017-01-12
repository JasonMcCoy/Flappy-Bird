//
//  GameManager.swift
//  FlappyBirdClone
//
//  Created by Deborah on 1/12/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation

class GameManager {
    
    static let instance = GameManager();
    private init() {}
    
    var birdIndex = Int(0);
    var birds = ["Blue", "Green", "Red"];
    
    func getBird() -> String {
        return birds[birdIndex];
    }
    
}
