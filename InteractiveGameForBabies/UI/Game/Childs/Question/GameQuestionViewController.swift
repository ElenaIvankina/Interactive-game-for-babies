//
//  GameQuestionViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameQuestionViewController: UIViewController {

    private var mediaType: MediaType = .none
    
    private var gameQuestionView: GameQuestionView {
        return self.view as! GameQuestionView
    }
    
    init(type: MediaType) {
        mediaType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = GameQuestionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestionData()
    }
    
    // MARK: - Private
    private func setQuestionData() {
        gameQuestionView.questionLabel.text = "Какое животное так говорит?"
        gameQuestionView.setupMedia(type: mediaType)
    }
}
