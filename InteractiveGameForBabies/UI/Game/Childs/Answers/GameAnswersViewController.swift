//
//  GameAnswersViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameAnswersViewController: UIViewController {
    
    private lazy var gameAnswersView = GameAnswersView()
    
    var cards: [CardProtocol]
    var delegate: GameDelegate
    
    init(cards: [CardProtocol], delegate: GameDelegate) {
        self.cards = cards
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
        setCards()
        setDelegate()
    }
    
    private func setCards() {
        gameAnswersView.setCards(cards: cards)
    }
    
    private func setDelegate() {
        gameAnswersView.setDelegate(delegate: delegate)
    }
}
