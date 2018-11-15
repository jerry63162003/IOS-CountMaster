//
//  GameViewController.swift
//  CountMaster
//
//  Created by user04 on 2018/9/15.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit
import LDProgressView

class GameViewController: UIViewController {
    
    //userChooseBtn
    @IBOutlet var buttonList: [UIButton]!
    
    //blackBoardNum
    @IBOutlet var labelList: [UILabel]!
    //sign
    @IBOutlet weak var operationLabel: UIImageView!
    //questionCount
    @IBOutlet weak var numberCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wrongImageView: UIImageView!
    @IBOutlet weak var timeView: UIView!
    
    var progressView = LDProgressView()
    let sound = SoundManager()
    
    var timer: Timer?
    var rightAnswerList: [Int] = []
    var operation: GameOperations?
    var rightNumbers: (Int, Int, Int)?
    var time = 60 {
        didSet {
            timeLabel.text = "\(time)"
            progressView.progress = CGFloat(Float(time) / 60.0)
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    var questionNumber = 0 {
        didSet {
            numberCountLabel.text = "第 \(questionNumber) 题"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        getFormula()
        if GameConfig.shared.isGameMusic {
            sound.playBackGroundSound()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func commonInit() {
        progressView = LDProgressView()
        progressView.color = UIColor.yellow
        progressView.progress = 1.00
        progressView.animate = true
        progressView.showText = false
        progressView.type = LDProgressGradient
        progressView.background = UIColor.gray
        timeView.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(timeView)
        }
        
        questionNumber = 1
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer) in
            self?.time -= 1
            if self?.time == 0 {
                self?.timer?.invalidate()
                self?.gameOver()
            }
        }
    }
    
    func getFormula() {
        rightAnswerList.removeAll()
        
        operation = GameFuction.getOperations()
        operationLabel.image = UIImage(named: operation!.rawValue)
        
        rightNumbers = GameFuction.getNumbersForOperation(gameOperation: operation!)
        
        var numberList: Array = [rightNumbers!.0, rightNumbers!.1, rightNumbers!.2]
        numberList = numberList.shuffle()
        
        for i in 0..<labelList.count {
            let label = labelList[i]
            label.adjustsFontSizeToFitWidth = true
            label.text = "\(numberList[i])"
        }
        
        print(rightNumbers!)
    }
    
    func checkIsRightAnswer(userAns: Bool) {
        var ans: Int!
        var isRight: Bool!
        guard let oneLab = Int(labelList[0].text!) else {
            return
        }
        guard let twoLab = Int(labelList[1].text!) else {
            return
        }
        guard let threeLab = Int(labelList[2].text!) else {
            return
        }
        
        switch operation! {
        case CountMaster.GameOperations.add:
            ans = oneLab + twoLab
            break
            
        case CountMaster.GameOperations.subtract:
            ans = oneLab - twoLab
            break
            
        case CountMaster.GameOperations.multiply:
            ans = oneLab * twoLab
            break
            
        case CountMaster.GameOperations.divide:
            ans = oneLab / twoLab
            break
        }
        
        if ans == threeLab {
            isRight = true
        } else {
            isRight = false
        }
        
        if isRight == userAns {
            score += 1
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.wrongImageView.alpha = 1.0
            }) { (complete) in
                if complete {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.wrongImageView.alpha = 0.0
                    })
                }
            }
        }
        questionNumber += 1
        getFormula()
    }
    
    func gameOver() {
        if score > GameConfig.shared.highScore {
            GameConfig.shared.highScore = score
        }
        if GameConfig.shared.isGameSound {
            sound.stopBackGroundSound()
        }
        sound.playOverSound()
        performSegue(withIdentifier: "toGameOver", sender: score)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            checkIsRightAnswer(userAns: false)
            break
            
        case 1:
            checkIsRightAnswer(userAns: true)
            break
            
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameOver" {
            let vc = segue.destination as! GameOverViewController
            vc.score = score
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
