//
//  BowlingFrameTests.swift
//  BowlingGameTests
//
//  Created by 2019_DEV_183 on 7/17/19.
//  Copyright © 2019 2019_DEV_183. All rights reserved.
//

import XCTest
@testable import BowlingGame

class BowlingFrameTests: XCTestCase {
    
    var game: GameController!
    
    override func setUp() {
        game = GameController()
    }
    
    override func tearDown() {
        game = nil
    }
    
    func testFramesForRollsOfThree() {
        mockAllOnes(for: &game)
        for index in 0..<20 {
            XCTAssertEqual(game.frameIndexForRoll(at: index), index/2)
        }
    }
    
    func testFramesForMiddleStrike() {
        mockMiddleStrike(for: &game)
        for index in 0...20 {
            switch index {
            case 0..<11:
                XCTAssertEqual(game.frameIndexForRoll(at: index), index/2)
            case 11...20:
                XCTAssertEqual(game.frameIndexForRoll(at: index), (index+1)/2)
            default:
                break
            }
        }
    }
    
    func testFramesForAllStrikes() {
        mockAllStrikes(for: &game)
        for index in 1...12 {
            switch index {
            case 1..<10:
                XCTAssertEqual(game.frameIndexForRoll(at: index), index)
            case 10...12:
                XCTAssertEqual(game.frameIndexForRoll(at: 10), 10)
            default:
                break
            }
        }
    }
        
    func testFramesForAllSpares() {
        mockAllSparesEven(for: &game)
        for index in 0..<20 {
            XCTAssertEqual(game.frameIndexForRoll(at: index), index/2)
        }
        XCTAssertEqual(game.frameIndexForRoll(at: 21), 10)
    }
}
