//
//  GameAnswersViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameAnswersViewController: UIViewController {
    
    private var gameAnswersView: GameAnswersView {
        return self.view as! GameAnswersView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = GameAnswersView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnswers()
    }
    
    // MARK: - Private
    
    private func setAnswers() {
        gameAnswersView.cardImages = [
            UIImage(named: "animal1"),
            UIImage(named: "animal2"),
            UIImage(named: "animal3"),
            UIImage(named: "animal4"),
            UIImage(named: "animal5"),
            UIImage(named: "animal6")
        ]
        gameAnswersView.collectionView.reloadData()
    }
}
