//
//  GameQuestionViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameQuestionViewController: UIViewController {
    
    private lazy var gameQuestionView = GameQuestionView()
    
    private var mediaType: MediaType
    
    init(type: MediaType) {
        mediaType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = gameQuestionView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameQuestionView.setMediaView(type: mediaType)
    }
}
