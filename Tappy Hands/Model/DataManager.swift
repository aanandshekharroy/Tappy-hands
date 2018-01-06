//
//  DataManager.swift
//  Tappy Hands
//
//  Created by Rashi Karanpuria on 31/12/17.
//  Copyright © 2017 Rashi. All rights reserved.
//

import Foundation
protocol DataProtocol {
    func getHighScore() -> Int
    func setHighScore(highScore:Int)
}
class DataManager: DataProtocol {
    let highScore = "highScore"
    func setHighScore(highScore: Int) {
        let userDefault = UserDefaults()
        userDefault.set(highScore, forKey: self.highScore)
    }
    
    func getHighScore() -> Int {
        let userDefault = UserDefaults()
        let highScore = userDefault.integer(forKey: self.highScore)
        return highScore
    }
    
    
}
