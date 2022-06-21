//
//  GameQuestionViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameQuestionViewController: UIViewController {

//    private var gameQuestionView = GameQuestionView()

    private let typeOfGame: TypeOfGame

//    var contentHeight: CGFloat {
//        return gameQuestionView.viewHeight
//    }

    //MARK: - Lifecycle
    init(typeOfGame: TypeOfGame) {
        self.typeOfGame = typeOfGame
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let gameQuestionView = GameQuestionView(typeOfGame: self.typeOfGame)
        self.view = gameQuestionView
    }
}
