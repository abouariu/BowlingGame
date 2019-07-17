//
//  BowlingGameTests.swift
//  BowlingGameTests
//
//  Created by 2019_DEV_183 on 7/17/19.
//  Copyright © 2019 2019_DEV_183. All rights reserved.
//

import XCTest
@testable import BowlingGame

class BowlingGameTests: XCTestCase {

    var game: GameController!
    
    override func setUp() {
        game = GameController()
    }

    override func tearDown() {
        game = nil
    }
    
    func testAllZeros() {
        mockAllMiss(for: &game)
        XCTAssertEqual(game.score(), 0)
    }
    
    func testAllOnes() {
        mockAllOnes(for: &game)
        XCTAssertEqual(game.score(), 20)
    }
    
    func testAllNines() {
        mockFirstNines(for: &game)
        XCTAssertEqual(game.score(), 90)
    }
    
    func testStrike() {
        mockMiddleStrike(for: &game)
        XCTAssertEqual(game.score(), 50)
    }
    
    func testAllStrikes() {
        mockAllStrikes(for: &game)
        XCTAssertEqual(game.score(), 300)
    }
    
    func testSpare() {
        mockMiddleSpare(for: &game)
        XCTAssertEqual(game.score(), 48)
    }
    
    func testAllSparesEven() {
        mockAllSparesEven(for: &game)
        XCTAssertEqual(game.score(), 150)
        
    }
    
    func testAllSparesUneven() {         
        mockAllSparesUneven(for: &game)
        XCTAssertEqual(game.score(), 180)
    }

}
