//
//  RollViewModel.swift
//  BowlingGame
//
//  Created by 2019_DEV_183 on 17/07/2019.
//  Copyright © 2019 2019_DEV_183. All rights reserved.
//

import Foundation
import UIKit

struct RollViewModel {
    func configure(cell: RollCell, with gameController: GameController, at indexPath: IndexPath) {
        cell.topLabel.text = String(gameController.frames[indexPath.section][indexPath.item])
        cell.bottomLabel.text = "\((indexPath.item + 1).elevatedOrdinal()) roll"
    }
}
