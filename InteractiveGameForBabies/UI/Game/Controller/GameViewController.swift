//
//  GameViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

protocol GameViewControllerProtocol: UIViewController {
    
    var mediaType: MediaType {get set}
    var gameSession: GameSessionProtocol {get set}
    var gameDelegate: GameDelegate {get set}
    var typeOfGame: TypeOfGame {get set}
    
}

class GameViewController: UIViewController, GameViewControllerProtocol {
    
    var mediaType: MediaType
    var gameSession: GameSessionProtocol
    var gameDelegate: GameDelegate
    var typeOfGame: TypeOfGame
    
    //MARK: - Views
    lazy var questionViewController = GameQuestionViewController(question: gameSession.currentQuestion, type: mediaType)
    lazy var answersViewController = GameAnswersViewController(cards: gameSession.currentRandomCards, delegate: gameDelegate)
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    init(gameSession: GameSessionProtocol, gameDelegate: GameDelegate, typeOfGame: TypeOfGame, type: MediaType) {
        self.gameSession = gameSession
        self.gameDelegate = gameDelegate
        self.typeOfGame = typeOfGame
        mediaType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addObserverToGameSession()
    }
    
    private func addObserverToGameSession() {
        gameSession.counterOfRightAnswers.addObserver(self, closure: { [weak self] number, _ in
            guard let self = self else {return}
            if number == self.gameSession.numberOfRightAnswers {
                self.makeGameEndAlert()
            }
        })
    }
    
    private func makeGameEndAlert() {
            let alert = UIAlertController(title: "Молодец, малыш!",
                                          message: "Сыграем еще?",
                                          preferredStyle: .alert)
    
            alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { [weak self] _ in
                guard let self = self else {return}
                self.gameDelegate.endGame()
            }))
    
            alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] _ in
                guard let self = self else {return}
                self.gameDelegate.newGame()
            }))
    
            self.present(alert, animated: true)
        }

        
    // MARK: - Private
    func configureView() {
        view.backgroundColor = .systemBackground
        
        configureNavigationController()
        configureScrollView()
        addQuestionViewController()
        addAnswersViewController()
    }
    
    private func configureNavigationController() {
        navigationItem.largeTitleDisplayMode = .never
        
        let homeImage = UIImage(systemName: "house.fill")
        navigationController?.navigationBar.backIndicatorImage = homeImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = homeImage
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
//        TODO нужно переопределить действие кнопки домой, чтобы она вызывала popToRootViewController, сейчас просто popViewController
//        let barButton = UIBarButtonItem(image: UIImage(systemName: "house.fill"), style: .bordered, target: self, action: #selector(homeButtonTapped))
//
//        navigationItem.backBarButtonItem = barButton
//        navigationController?.navigationBar.topItem?.backBarButtonItem = barButton
    }
    
//    @objc func homeButtonTapped() {
//        self.navigationController?.popToRootViewController(animated: true)
//    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func addQuestionViewController() {
        addChild(questionViewController)
        let questionView = questionViewController.view!
        scrollView.addSubview(questionView)
        questionViewController.didMove(toParent: self)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionView.heightAnchor.constraint(equalToConstant: 80)
            
            //TODO менять константу по высоте на адаптивную верстку
        ])
    }
    
    private func addAnswersViewController() {
        addChild(answersViewController)
        let answersView = answersViewController.view!
        scrollView.addSubview(answersView)
        answersViewController.didMove(toParent: self)
        
        answersView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            answersView.topAnchor.constraint(equalTo: questionViewController.view.bottomAnchor, constant: 32),
            answersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            answersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            answersView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            answersView.heightAnchor.constraint(equalToConstant: 300)
            
            //TODO менять константу по высоте на адаптивную верстку
        ])
    }
}

