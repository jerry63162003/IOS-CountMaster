//
//  GameOverViewController.swift
//  CountMaster
//
//  Created by user04 on 2018/9/15.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Init()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Init() {
        scoreLabel.text = "得分: \(score)"
    }
    

}
