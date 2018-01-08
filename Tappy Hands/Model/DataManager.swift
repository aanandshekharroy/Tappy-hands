//
//  DataManager.swift
//  Tappy Hands
//
//  Created by Aanand on 31/12/17.
//  Copyright © 2017 Aanand. All rights reserved.
//

import Foundation
protocol DataProtocol {
    func getHighScore() -> Int //Get highest score saved from UserDefaults
    func setHighScore(highScore:Int) //Save highest score in UserDefaults
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
