//
//  ViewController.swift
//  BowlingGame
//
//  Created by 2019_DEV_183 on 7/17/19.
//  Copyright © 2019 2019_DEV_183. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var rollScoreButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var gameController: GameController = GameController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    
    @IBAction func resetButtonTouched(_ sender: UIButton) {
        resetGame()
        collectionView.reloadData()
    }
    
    @IBAction func rollScoreButtonTouched(_ sender: UIButton) {
        if (gameController.isGameComplete()) {
            processScore()
        } else {
            processRoll()
        }
    }
    
    internal func processScore() {
        rollScoreButton.setTitle(String(gameController.score()), for: .normal)
    }
    
    internal func processRoll() {
        showAlertInput(title: "How many pins did you hit?") { [weak self] (result) in
            guard let self = self, let text = result, let result = Int(text) else {
                return
            }
            self.gameController.roll(result)
            self.collectionView.reloadData()
            self.updateRollScoreButtonLayout()
            self.scrollToLastFrame()
        }
    }
    
    func resetGame() {
        gameController = GameController()
        updateRollScoreButtonLayout()
    }
    
    internal func updateRollScoreButtonLayout() {
        if (gameController.isGameComplete()) {
            rollScoreButton.setTitle("Get Score", for: .normal)
        } else {
            rollScoreButton.setTitle("Roll", for: .normal)
        }
    }
    
    internal func scrollToLastFrame() {        
        let sectionIndex = self.gameController.frames.count - 1
        let itemIndex = self.gameController.frames[sectionIndex].count - 1
        self.collectionView.scrollToItem(at: IndexPath(item: itemIndex, section: sectionIndex), at: .top, animated: true)
    }

}

/// Extension for collection view delegate & data source
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameController.frames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameController.frames[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rollCell", for: indexPath) as! RollCell
        let rollViewModel = RollViewModel()
        rollViewModel.configure(cell: cell, with: gameController, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        sectionHeader.sectionHeaderlabel.text = "\((indexPath.section + 1).elevatedOrdinal()) frame"
        return sectionHeader
    }
}

/// Extension for utils
extension UIViewController {
    func showAlertInput(title: String, completion: ((String?) -> ())?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields?[0] {
                completion?(textField.text)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderlabel: UILabel!
}

extension Int {
    func elevatedOrdinal() -> String {
        switch self {
        case 1:
            return "1st"
        case 2:
            return "2nd"
        case 3:
            return "3rd"
        default:
            return "\(self)th"
        }
    }
}
