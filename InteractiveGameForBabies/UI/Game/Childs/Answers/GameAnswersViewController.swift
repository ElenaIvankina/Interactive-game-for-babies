//
//  GameAnswersViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameAnswersViewController: UIViewController {
    
    private lazy var gameAnswersView = GameAnswersView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = gameAnswersView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnswers()
    }
    
    private func setAnswers() {
        gameAnswersView.cardImages = [
            UIImage(named: "animal1"),
            UIImage(named: "animal2"),
            UIImage(named: "animal3"),
            UIImage(named: "animal4"),
            UIImage(named: "animal5"),
            UIImage(named: "animal6")
        ]
    }
}
