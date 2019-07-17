//
//  GameController.swift
//  BowlingGame
//
//  Created by 2019_DEV_183 on 7/17/19.
//  Copyright © 2019 2019_DEV_183. All rights reserved.
//

import Foundation

struct GameController {
    
    var frames = [[Int]]()
    var rolls = Array.init(repeating: 0, count: 21)
    var currentRoll = 0
    
    mutating func roll(_ pins: Int) {
        guard !isGameComplete() else {
            return
        }
        updateFrames(with: pins)
        rolls[currentRoll] = pins
        currentRoll = currentRoll + 1
    }
    
    /**
     Determines if the game has finished by counting the frames and the number of rolls in the last frame.
     Returns: (Bool) the status of the game completion.
     */
    func isGameComplete() -> Bool {
        guard frames.count == 10 else {
            return false
        }
        let lastFrameIndex = frames.count - 1
        return ((isSpare(frameIndex: lastFrameIndex) || isStrike(frameIndex: lastFrameIndex)) && frames[lastFrameIndex].count == 3) ||
            ((!isSpare(frameIndex: lastFrameIndex) && !isStrike(frameIndex: lastFrameIndex)) && frames[lastFrameIndex].count == 2)
    }
    
    /**
     Updates the frames by adding the roll to the last frame or by creating a new frame with the roll.
     Parameter pins: the number of hit pins.
    */
    mutating func updateFrames(with pins: Int) {
        let frameIndex = frameIndexForRoll(at: currentRoll)
        if frameIndex == frames.count {
            if frameIndex < 10 {
                frames.append([pins])
            } else {
                frames[frames.count - 1].append(pins)
            }
        } else if frameIndex < frames.count {
            frames[frameIndex].append(pins)
        }
    }
    
    /**
     Calculates the index of a frame containing a roll with a given index.
     Parameter index: the index of the roll.
     Returns: (Int) the index of the frame containing the roll.
     */
    func frameIndexForRoll(at index: Int) -> Int {
        var frameIndex = 0
        var roll = 0
        while roll <= index {
            if isStrike(rollIndex: roll) {
                roll = roll + 1
            } else {
                roll = roll + 2
            }
            if frameIndex <= 10 {
                frameIndex = frameIndex + 1
            }
        }
        return frameIndex - 1
    }
    
    /**
     Calculates the score based on the rolls.
     Returns: (Int) the final score.
     */
    func score() -> Int {
        var score = 0
        var roll = 0
        for _ in 0..<10 {
            if isStrike(rollIndex: roll) {
                score = score + 10 + strikeBonus(rollIndex: roll)
                roll = roll + 1
            } else if isSpare(rollIndex: roll) {
                score = score + 10 + spareBonus(rollIndex: roll)
                roll = roll + 2
            } else {
                score = score + sumOfRollsInFrame(rollIndex: roll)
                roll = roll + 2
            }
        }
        return score
    }
    
    func sumOfRollsInFrame(rollIndex: Int) -> Int {
        return rolls[rollIndex] + rolls[rollIndex + 1]
    }
    
    func isStrike(rollIndex: Int) -> Bool {
        return rolls[rollIndex] == 10
    }
    
    func isStrike(frameIndex: Int) -> Bool {
        if frameIndex < frames.count {
            return frames[frameIndex][0] == 10
        }
        return false
    }
    
    func strikeBonus(rollIndex: Int) -> Int {
        return rolls[rollIndex + 1] + rolls[rollIndex + 2]
    }
    
    func isSpare(rollIndex: Int) -> Bool {
        return rolls[rollIndex] + rolls[rollIndex + 1] == 10
    }
    
    func isSpare(frameIndex: Int) -> Bool {
        if frameIndex < frames.count && frames[frameIndex].count == 2 {
            return frames[frameIndex][0] + frames[frameIndex][1] == 10
        }
        return false
    }
    
    func spareBonus(rollIndex: Int) -> Int {
        return rolls[rollIndex + 2]
    }
    
}
