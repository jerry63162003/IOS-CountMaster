//
//  ViewController.swift
//  CountMaster
//
//  Created by user04 on 2018/9/15.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var modeButton: UIButton!
    @IBOutlet weak var highScore: UILabel!
    let config = GameConfig.shared
    let scoreText = GameConfig.shared.highScore
    var modeButtonsArr: [UIButton] = []
    
    lazy var modeView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image: #imageLiteral(resourceName: "难度选择bg"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "叉"), for: .normal)
        cancelButton.tag = 31
        cancelButton.addTarget(self, action: #selector(modeSelectClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage).offset(15)
            make.left.equalTo(bgImage.snp.right)
        })
        
        let buttonEasy = UIButton()
        buttonEasy.addTarget(self, action: #selector(modeSelectClick(_:)), for: .touchUpInside)
        buttonEasy.tag = 10
        buttonEasy.setImage(#imageLiteral(resourceName: "简单绿"), for: .normal)
        bgImage.addSubview(buttonEasy)
        buttonEasy.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(bgImage).offset(115)
        }
        
        let buttonDiff = UIButton()
        buttonDiff.addTarget(self, action: #selector(modeSelectClick(_:)), for: .touchUpInside)
        buttonDiff.tag = 11
        buttonDiff.setImage(#imageLiteral(resourceName: "中等绿"), for: .normal)
        bgImage.addSubview(buttonDiff)
        buttonDiff.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(buttonEasy.snp.bottom).offset(24)
        }
        
        let buttonHell = UIButton()
        buttonHell.addTarget(self, action: #selector(modeSelectClick(_:)), for: .touchUpInside)
        buttonHell.tag = 12
        buttonHell.setImage(#imageLiteral(resourceName: "困难绿"), for: .normal)
        bgImage.addSubview(buttonHell)
        buttonHell.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(buttonDiff.snp.bottom).offset(24)
        }
        
        modeButtonsArr = [buttonEasy, buttonDiff, buttonHell]
        
        switch config.gameLevel {
        case .easy:
            buttonEasy.setImage(#imageLiteral(resourceName: "简单黄"), for: .normal)
            break
        case .mid:
            buttonDiff.setImage(#imageLiteral(resourceName: "中等黄"), for: .normal)
            break
        case .diff:
            buttonHell.setImage(#imageLiteral(resourceName: "困难黄"), for: .normal)
            break
        }
        
        return bgView
    }()
    
    lazy var settingView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image:#imageLiteral(resourceName: "设置弹窗"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "叉"), for: .normal)
        cancelButton.tag = 31
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage).offset(15)
            make.left.equalTo(bgImage.snp.right)
        })
        
        let labelMusic = UILabel()
        labelMusic.textColor = UIColor(red:1.00, green:0.29, blue:0.45, alpha:1.0)
        labelMusic.text = "音乐"
        labelMusic.font = UIFont.systemFont(ofSize: 21)
        bgImage.addSubview(labelMusic)
        labelMusic.snp.makeConstraints({ (make) in
            make.left.equalTo(bgImage).offset(56)
            make.top.equalTo(bgImage).offset(128)
        })
        
        let labelEffect = UILabel()
        labelEffect.textColor = UIColor(red:1.00, green:0.29, blue:0.45, alpha:1.0)
        labelEffect.text = "音效"
        labelEffect.font = UIFont.systemFont(ofSize: 21)
        bgImage.addSubview(labelEffect)
        labelEffect.snp.makeConstraints({ (make) in
            make.left.equalTo(labelMusic)
            make.top.equalTo(labelMusic.snp.bottom).offset(30)
        })
        
        let musicButton = UIButton()
        musicButton.isSelected = config.isGameMusic
        musicButton.setImage(#imageLiteral(resourceName: "on"), for: .selected)
        musicButton.setImage(#imageLiteral(resourceName: "off"), for: .normal)
        musicButton.tag = 10
        musicButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(musicButton)
        musicButton.snp.makeConstraints({ (make) in
            make.left.equalTo(labelMusic.snp.right).offset(14)
            make.centerY.equalTo(labelMusic)
        })
        
        let soundButton = UIButton()
        soundButton.isSelected = config.isGameSound
        soundButton.setImage(#imageLiteral(resourceName: "on"), for: .selected)
        soundButton.setImage(#imageLiteral(resourceName: "off"), for: .normal)
        soundButton.tag = 11
        soundButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(soundButton)
        soundButton.snp.makeConstraints({ (make) in
            make.left.equalTo(labelEffect.snp.right).offset(14)
            make.centerY.equalTo(labelEffect)
        })
        
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        button.tag = 30
        button.setImage(#imageLiteral(resourceName: "关于我们"), for: .normal)
        bgImage.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.top.equalTo(labelEffect.snp.bottom).offset(43)
        }
        
        return bgView
    }()
    
    lazy var informationView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image:#imageLiteral(resourceName: "玩法说明bg"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "叉"), for: .normal)
        cancelButton.tag = 32
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage).offset(15)
            make.left.equalTo(bgImage.snp.right)
        })

        let arr = ["1、倒计时1分钟，选择当前题目是否正确。","2、如果错误不记分，正确加100分。","3、时间走完游戏结束，最后统计得分情况。","4、快来挑战吧！看看谁是得分王！"]
        for i in 0..<arr.count{
            let label1 = UILabel()
            label1.textColor = UIColor(red:0.05, green:0.32, blue:0.59, alpha:1.0)
            label1.font = UIFont.systemFont(ofSize: 12)
            label1.text = arr[i]
            label1.numberOfLines = 0
            bgView.addSubview(label1)
            label1.snp.makeConstraints({ (make) in
                make.centerX.equalTo(bgImage)
                make.top.equalTo(bgImage).offset(100 + i * 180 / 4)
                make.width.equalTo(143)
                make.height.equalTo(180 / 4)
            })
        }
        
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScore.text = "最高分:\(scoreText)"
        commonInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func commonInit() {
        let mode = config.gameLevel.rawValue
        
        modeButton.setImage(UIImage(named: "难度\(mode)"), for: .normal)
    }
    
    func openWebView() {
        let webview = WebViewController()
        webview.urlStr = "http://static.0955gw.com/CountMaster/index.html"
        var top = UIApplication.shared.keyWindow?.rootViewController
        while ((top?.presentedViewController) != nil) {
            top = top?.presentedViewController
        }
        top?.present(webview, animated: true, completion: nil)
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        
        
        if sender.tag == 10 {
            openInformation()
        }
        
        if sender.tag == 11 {
            openMode()
        }
        
        if sender.tag == 12 {
            openSetting()
        }
        
        if sender.tag == 30 {
            openWebView()
        }
        
        if sender.tag == 31 {
            settingView.removeFromSuperview()
        }
        
        if sender.tag == 32 {
            informationView.removeFromSuperview()
        }
    }
    
    @objc func settingClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.tag == 10 {
            //音樂
            config.isGameMusic = sender.isSelected
        }
        if sender.tag == 11 {
            //音效
            config.isGameSound = sender.isSelected
        }
    }
    
    @objc func modeSelectClick(_ sender: UIButton) {
        
        if sender.tag == 31 {
            modeView.removeFromSuperview()
            return
        }
        
        let button1 = modeButtonsArr[0]
        let button2 = modeButtonsArr[1]
        let button3 = modeButtonsArr[2]
        
        var image = UIImage()
        switch sender.tag {
        case 10:
            config.gameLevel = .easy
            sender.setImage(#imageLiteral(resourceName: "简单黄"), for: .normal)
            button2.setImage(#imageLiteral(resourceName: "中等绿"), for: .normal)
            button3.setImage(#imageLiteral(resourceName: "困难绿"), for: .normal)
            image = #imageLiteral(resourceName: "难度easy")
            break
        case 11:
            config.gameLevel = .mid
            sender.setImage(#imageLiteral(resourceName: "中等黄"), for: .normal)
            button1.setImage(#imageLiteral(resourceName: "简单绿"), for: .normal)
            button3.setImage(#imageLiteral(resourceName: "困难绿"), for: .normal)
            image = #imageLiteral(resourceName: "难度mid")
            break
        case 12:
            config.gameLevel = .diff
            sender.setImage(#imageLiteral(resourceName: "困难黄"), for: .normal)
            button1.setImage(#imageLiteral(resourceName: "简单绿"), for: .normal)
            button2.setImage(#imageLiteral(resourceName: "中等绿"), for: .normal)
            image = #imageLiteral(resourceName: "难度diff")
            break
        default:
            break
        }
        
        modeButton.setImage(image, for: .normal)
        
        modeView.removeFromSuperview()
    }
    
    func openInformation() {
        view.addSubview(informationView)
        informationView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }
    
    func openMode() {
        view.addSubview(modeView)
        modeView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }
    
    func openSetting() {
        view.addSubview(settingView)
        settingView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }
    
}

