//
//  HomeViewModel.swift
//  Tappy Hands
//
//  Created by Rashi Karanpuria on 31/12/17.
//  Copyright © 2017 Rashi. All rights reserved.
//

import Foundation
protocol HomeViewModelProtocol {
    func getHighScore() -> String
}
class HomeViewModel:HomeViewModelProtocol    {
    let model:DataProtocol = DataManager()
    func getHighScore() -> String {
        return String(model.getHighScore())
    }
    
    
}
