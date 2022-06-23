//
//  GameAnswersViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameAnswersViewController: UIViewController {

    lazy private var gameAnswersView = GameAnswersView()

    private var delegate: GameDelegate

    init(delegate: GameDelegate) {
        self.delegate = delegate
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
        setDelegate()
    }
    
    func reloadCollectionView () {
        gameAnswersView.reloadCollectionView()
    }


    private func setDelegate() {
        gameAnswersView.setDelegate(delegate: delegate)
    }
}
