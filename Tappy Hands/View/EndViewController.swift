//
//  EndViewController.swift
//  Tappy Hands
//
//  Created by Aanand on 29/12/17.
//  Copyright © 2017 Aanand. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

class EndViewController: UIViewController ,GADBannerViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate{
    var scores:String!
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var scoresLabel: UILabel!
    let PREFIX_SCORE_TEXT = "My total score was "
    let THINK_YOU_CAN_BEAT_ME = "Think you can beat me?"
    let ACCOUNT = "Account"
    let OK = "Ok"
    let WARNING = "Warning"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresLabel.text = scores
        // Setting up the adView
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-6285653045864394/8616734152"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    // Shows the adView if ad is received
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
        
    }
    // Removes the adView if ad is not received
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    // Sends score through email
    @IBAction func sendEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail(){
            let mail:MFMailComposeViewController = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject(THINK_YOU_CAN_BEAT_ME)
            mail.setToRecipients(nil)
            mail.setMessageBody(PREFIX_SCORE_TEXT+"\(scores)", isHTML: false)
            self.present(mail, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title:ACCOUNT,message:"Log in to your account",preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Restarts the game
    @IBAction func restartGame(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    // Sends score through SMS
    @IBAction func sendSMS(_ sender: Any) {
        if MFMessageComposeViewController.canSendText(){
            let message:MFMessageComposeViewController = MFMessageComposeViewController()
            message.messageComposeDelegate = self
            message.recipients = nil
            message.body = "\(PREFIX_SCORE_TEXT) \(scores)"
            self.present(message, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title:WARNING,message:"This device doesn't have SMS capability",preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: OK, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }

}
