//
//  BowlingSceneMocks.swift
//  BowlingGameTests
//
//  Created by 2019_DEV_183 on 7/17/19.
//  Copyright © 2019 2019_DEV_183. All rights reserved.
//

import Foundation

@testable import BowlingGame

func rollMultiple(times rolls: Int, pins: Int, for game: inout GameController) {
    for _ in 0..<rolls {
        game.roll(pins)
    }
}

func mockAllMiss(for game: inout GameController) {
    rollMultiple(times: 20, pins: 0, for: &game)
}

func mockAllOnes(for game: inout GameController) {
    rollMultiple(times: 20, pins: 1, for: &game)
}

func mockFirstNines(for game: inout GameController) {
    for _ in 1...10 {
        game.roll(9)
        game.roll(0)
    }
}

func mockAllStrikes(for game: inout GameController) {
    rollMultiple(times: 12, pins: 10, for: &game)
}

func mockAllSparesEven(for game: inout GameController) {
    rollMultiple(times: 21, pins: 5, for: &game)
}

func mockAllSparesUneven(for game: inout GameController) {
    for _ in 1...10 {
        game.roll(8)
        game.roll(2)
    }
    game.roll(8)
}

func mockMiddleStrike(for game: inout GameController) {
    rollMultiple(times: 10, pins: 2, for: &game)
    game.roll(10)
    rollMultiple(times: 8, pins: 2, for: &game)
}

func mockMiddleSpare(for game: inout GameController) {
    rollMultiple(times: 9, pins: 2, for: &game)
    game.roll(8)
    rollMultiple(times: 10, pins: 2, for: &game)
}
