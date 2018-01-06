//
//  ViewController.swift
//  Tappy Hands
//
//  Created by Rashi Karanpuria on 28/12/17.
//  Copyright © 2017 Rashi. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController , GADBannerViewDelegate{

    @IBOutlet weak var labelHighScore: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var buttonStartGame: UIButton!
    let homeViewModel:HomeViewModelProtocol = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        labelHighScore.layer.cornerRadius=5.0
        
        buttonStartGame.layer.cornerRadius=5.0
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
    override func viewWillAppear(_ animated: Bool) {
        highScore.text = homeViewModel.getHighScore()
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }


}

