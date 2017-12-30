//
//  GameViewController.swift
//  Tappy Hands
//
//  Created by Rashi Karanpuria on 28/12/17.
//  Copyright © 2017 Rashi. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameViewController: UIViewController , GADBannerViewDelegate{
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tapMeButton: UIButton!
    @IBOutlet weak var timeRemaining: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var scoreDisplay: UILabel!
    var tapCount = 0
    var gameStartCountdown = 3
    var gameStartTimer = Timer()
    var gameEndTimer = Timer()
    var timeToEnd = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.layer.cornerRadius = 5.0
        scoreLabel.layer.cornerRadius = 5.0
        tapMeButton.layer.cornerRadius = 5.0
        scoreDisplay.text = String(tapCount)
        
    tapMeButton.setTitle(String(gameStartCountdown), for: .normal)
        tapMeButton.isEnabled = false
        gameStartTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.countdown), userInfo: nil, repeats: true)
        bannerView.isHidden = true
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-6285653045864394/8616734152"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
        
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapMeClicked(_ sender: Any) {
        tapCount += 1
        scoreDisplay.text = String(tapCount)
    }
    
    @objc func countdown()  {
        gameStartCountdown -= 1
        tapMeButton.setTitle(String(gameStartCountdown), for: .normal)
        if(gameStartCountdown==0){
            gameStartTimer.invalidate()
            tapMeButton.isEnabled = true
            tapMeButton.setTitle("Tap Me", for: .normal)
            gameEndTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameEndingTime), userInfo: nil, repeats: true)
        }
    }
    @objc func gameEndingTime()  {
        timeToEnd -= 1
        timeRemaining.text = String(timeToEnd)
        if timeToEnd == 0{
            tapMeButton.isEnabled = false
            gameEndTimer.invalidate()
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(endGame), userInfo: nil, repeats: false)
            
            let userDefault = UserDefaults.standard
            let highestScore = userDefault.string(forKey: "highScore")
            if highestScore==nil{
                    userDefault.setValue(scoreDisplay.text, forKey: "highScore")
            }else{
                if Int(highestScore!)! < Int(scoreDisplay.text!)! {
                    userDefault.setValue(scoreDisplay.text, forKey: "highScore")
                }
            }
            
        }
    }
    
    @objc func endGame()  {
        let vc = UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
        vc.scores = scoreDisplay.text
        self.present(vc, animated: true, completion: nil)
    }

}
