//
//  ViewController.swift
//  Tappy Hands
//
//  Created by Rashi Karanpuria on 28/12/17.
//  Copyright © 2017 Rashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelHighScore: UILabel!
    @IBOutlet weak var buttonStartGame: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelHighScore.layer.cornerRadius=5.0
        buttonStartGame.layer.cornerRadius=5.0
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
