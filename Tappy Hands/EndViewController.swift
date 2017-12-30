//
//  EndViewController.swift
//  Tappy Hands
//
//  Created by Rashi Karanpuria on 29/12/17.
//  Copyright © 2017 Rashi. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

class EndViewController: UIViewController ,GADBannerViewDelegate,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate{
    var scores:String!
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var scoresLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresLabel.text = scores
        // Do any additional setup after loading the view.bannerView.isHidden = true
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
    @IBAction func sendEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail(){
            let mail:MFMailComposeViewController = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Think you can beat me?")
            mail.setToRecipients(nil)
            mail.setMessageBody("My total score was \(scores)", isHTML: false)
            self.present(mail, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title:"Account",message:"Log in to your account",preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func restartGame(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendSMS(_ sender: Any) {
        if MFMessageComposeViewController.canSendText(){
            let message:MFMessageComposeViewController = MFMessageComposeViewController()
            message.messageComposeDelegate = self
            message.recipients = nil
            message.body = "My total score was \(scores)"
            self.present(message, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title:"Warning",message:"This device doesn't have SMS capability",preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
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
