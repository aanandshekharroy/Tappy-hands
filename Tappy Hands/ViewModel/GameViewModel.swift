//
//  GameViewModel.swift
//  Tappy Hands
//
//  Created by Aanand on 31/12/17.
//  Copyright © 2017 Aanand. All rights reserved.
//

import Foundation
import RxSwift

protocol GameViewModelProtocol {
    func tapMeButtonClicked()
    func getScoreObservable()->Observable<Int>
    func saveHighScore(scoreText:String)
}
class GameViewModel: GameViewModelProtocol {
    let model:DataProtocol = DataManager()
    func saveHighScore(scoreText:String) {
        if(Int(scoreText)! > model.getHighScore()){
            model.setHighScore(highScore: Int(scoreText)!)
        }
    }
    
    func getScoreObservable() -> Observable<Int> {
        return score.asObservable()
    }
    
    var score = Variable<Int>(0)
    
    func tapMeButtonClicked() {
        score.value = score.value + 1
    }
    
    
    
    
}
