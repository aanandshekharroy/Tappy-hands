//
//  EndViewController.swift
//  Tappy Hands
//
//  Created by Rashi Karanpuria on 29/12/17.
//  Copyright © 2017 Rashi. All rights reserved.
//

import UIKit
import Social
class EndViewController: UIViewController {
    var scores:String!
    
    @IBOutlet weak var scoresLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresLabel.text = scores
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func shareTwitter(_ sender: Any) {
    }
    
    @IBAction func restartGame(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    

}
