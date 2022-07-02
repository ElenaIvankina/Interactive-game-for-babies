//
//  GameAnswersViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameAnswersViewController: UIViewController {

    lazy var gameAnswersView = GameAnswersView()

    override func loadView() {
        view = gameAnswersView
    }

    func reloadCollectionView () {
        gameAnswersView.reloadCollectionView()
    }
}
