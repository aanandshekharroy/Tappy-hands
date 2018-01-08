//
//  GameViewController.swift
//  Tappy Hands
//
//  Created by Aanand on 28/12/17.
//  Copyright © 2017 Aanand. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RxSwift
import RxCocoa
class GameViewController: UIViewController , GADBannerViewDelegate{
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tapMeButton: UIButton!
    @IBOutlet weak var timeRemaining: UILabel!
    var disposeBag = DisposeBag()
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var scoreDisplay: UILabel!
    let gameViewModel:GameViewModelProtocol = GameViewModel()
    var gameStartCountdown = 3
    var gameStartTimer = Timer()
    var gameEndTimer = Timer()
    var timeToEnd = 10
    let TAP_ME = "Tap Me"
    let MAIN = "Main"
    let END_GAME_IDENTIFIER = "endGame"
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.layer.cornerRadius = 5.0
        scoreLabel.layer.cornerRadius = 5.0
        
        tapMeButton.setTitle(String(gameStartCountdown), for: .normal)
        tapMeButton.isEnabled = false
        //Starting 3 sconds timer (after which game starts)
        gameStartTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.countdown), userInfo: nil, repeats: true)
        //Setting up adView
        bannerView.isHidden = true
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-6285653045864394/8616734152"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        //Binding tap button to tap counts variable
        tapMeButton.rx.tap
            .subscribe {[weak self] onNext_ in
                self?.gameViewModel.tapMeButtonClicked()
            }.disposed(by: disposeBag)
        gameViewModel.getScoreObservable()
            .map({String($0)})
            .bind(to: scoreDisplay.rx.text)
            .disposed(by: disposeBag)
    }
    //Shows adView if ad is received
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
        
    }
    //Removes adView if ad is not received
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    // Counts down from 3 to 0, then starts the game
    @objc func countdown()  {
        gameStartCountdown -= 1
        tapMeButton.setTitle(String(gameStartCountdown), for: .normal)
        if(gameStartCountdown==0){
            gameStartTimer.invalidate()
            tapMeButton.isEnabled = true
            tapMeButton.setTitle(TAP_ME, for: .normal)
            gameEndTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameEndingTime), userInfo: nil, repeats: true)
        }
    }
    //Called every second the game is running
    @objc func gameEndingTime()  {
        timeToEnd -= 1
        timeRemaining.text = String(timeToEnd)
        
        if timeToEnd == 0{ // If the game time is over
            tapMeButton.isEnabled = false
            gameEndTimer.invalidate()
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(endGame), userInfo: nil, repeats: false)
            //Saving the score
            gameViewModel.saveHighScore(scoreText: scoreDisplay.text!)
            
        }
    }
    // Called when game ends, then opens Share score page
    @objc func endGame()  {
        let vc = UIStoryboard(name:MAIN,bundle:nil).instantiateViewController(withIdentifier: END_GAME_IDENTIFIER) as! EndViewController
        vc.scores = scoreDisplay.text
        self.present(vc, animated: true, completion: nil)
    }

}
