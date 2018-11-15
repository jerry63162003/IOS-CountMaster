//
//  GameFunction.swift
//  CountMaster
//
//  Created by user04 on 2018/9/17.
//  Copyright © 2018年 jerryHU. All rights reserved.
//

import UIKit

enum GameOperations: String {
    case add = "加号"
    case subtract = "减号"
    case multiply = "乘号"
    case divide = "除号"
}

class GameFuction: NSObject {
    
    static func getOperations() -> GameOperations {
        let gameLevel = GameConfig.shared.gameLevel
        var probability = 10
        switch gameLevel {
        case .easy:
            probability = 8
        case .mid:
            probability = 5
        case .diff:
            probability = 3
        }
        
        let random = arc4random_uniform(10)
        let randomOperation = arc4random_uniform(2)
        if random < probability {
            switch randomOperation {
            case 0:
                return .add
            case 1:
                return .subtract
            default:
                return .add
            }
        }else {
            switch randomOperation {
            case 0:
                return .multiply
            case 1:
                return .divide
            default:
                return .multiply
            }
        }
    }
    
    static func getRandomNumber() -> Int {
        let gameLevel = GameConfig.shared.gameLevel
        var minNumber = 0
        var maxNumber = 0
        switch gameLevel {
        case .easy:
            minNumber = 1
            maxNumber = 50
            break
        case .mid:
            minNumber = 10
            maxNumber = 90
            break
        case .diff:
            minNumber = 10
            maxNumber = 490
            break
        }
        
        return Int(arc4random_uniform(UInt32(maxNumber))) + minNumber
    }
    
    static func getNumbersForOperation(gameOperation: GameOperations) -> (Int, Int, Int) {
        
        var randomFirstNumber = getRandomNumber()
        var randomSecondNumber = getRandomNumber()
        
        var resultNumber = 0
        switch gameOperation {
        case .add:
            resultNumber = randomFirstNumber + randomSecondNumber
            break
        case .subtract:
            if randomFirstNumber > randomSecondNumber {
                resultNumber = randomFirstNumber - randomSecondNumber
            }else {
                resultNumber = randomSecondNumber - randomFirstNumber
                let number = randomFirstNumber
                randomFirstNumber = randomSecondNumber
                randomSecondNumber = number
            }
            break
        case .multiply:
            resultNumber = randomFirstNumber * randomSecondNumber
            break
        case .divide:
            let result = randomFirstNumber * randomSecondNumber
            resultNumber = randomFirstNumber
            randomFirstNumber = result
            break
        }
        
        return (randomFirstNumber, randomSecondNumber, resultNumber)
    }
    
    static func isRightAnswer(answers:(Int, Int, Int), numbers: (Int, Int, Int), operation: GameOperations) -> Bool {
        let rightAnswer = numbers.2
        var answer: Int?
        switch operation {
        case .add:
            answer = answers.0 + answers.1
            break
        case .subtract:
            answer = answers.0 - answers.1
            break
        case .multiply:
            answer = answers.0 * answers.1
            break
        case .divide:
            answer = answers.0 / answers.1
            break
        }
        
        guard answer != nil else {
            return false
        }
        
        if rightAnswer == answer! && rightAnswer == answers.2 {
            return true
        }
        
        return false
    }
}

extension Array {
    public func shuffle() -> Array {
        var list = self
        for index in 0..<list.count {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }
}

