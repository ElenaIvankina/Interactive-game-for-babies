//
//  GameViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

protocol GameViewControllerProtocol: UIViewController {
    
    var mediaType: MediaType { get set }
    var gameSession: GameSessionProtocol { get set }
    var gameDelegate: GameDelegate { get set }
    var typeOfGame: TypeOfGame { get set }
}

class GameViewController: UIViewController, GameViewControllerProtocol {
    
    internal var mediaType: MediaType
    internal var gameSession: GameSessionProtocol
    internal var gameDelegate: GameDelegate
    internal var typeOfGame: TypeOfGame
    
    // MARK: - Views
    lazy var questionViewController = GameQuestionViewController(question: gameSession.currentQuestion, type: mediaType)
    lazy var answersViewController = GameAnswersViewController(cards: gameSession.currentRandomCards, delegate: gameDelegate)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let scrollContentView: UIView = {
        let scrollView = UIView()
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
        gameSession
            .counterOfRightAnswers
            .addObserver(self, closure: { [weak self] number, _ in
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
        
        alert.addAction(UIAlertAction(title: "Нет",
                                      style: .default,
                                      handler: { [weak self] _ in
            guard let self = self else {return}
            self.gameDelegate.endGame()
        }))
        
        alert.addAction(UIAlertAction(title: "Да",
                                      style: .default,
                                      handler: { [weak self] _ in
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
        
        if let navigationBar = navigationController?.navigationBar {
            let homeImage = UIImage(systemName: "house.fill")
            navigationBar.backIndicatorImage = homeImage
            navigationBar.backIndicatorTransitionMaskImage = homeImage
            navigationBar.topItem?.backButtonDisplayMode = .minimal
        }
        
        navigationItem.hidesBackButton = true
        
        let newBackButton = UIBarButtonItem(image: UIImage(systemName: "house.fill"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(homeButtonTapped))
        
        navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func homeButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func configureScrollView() {
        scrollView.addSubview(scrollContentView)
        view.addSubview(scrollView)
        
        let heightConstraint = scrollContentView
            .heightAnchor
            .constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            scrollView
                .topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView
                .trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView
                .leadingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView
                .bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollContentView
                .topAnchor
                .constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollContentView
                .trailingAnchor
                .constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollContentView
                .leadingAnchor
                .constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollContentView
                .bottomAnchor
                .constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollContentView
                .widthAnchor
                .constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func addQuestionViewController() {
        addChild(questionViewController)
        let questionView = questionViewController.view!
        scrollContentView.addSubview(questionView)
        questionViewController.didMove(toParent: self)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionView
                .topAnchor
                .constraint(equalTo: scrollContentView.topAnchor),
            questionView
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            questionView
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            questionView
                .heightAnchor
                .constraint(equalToConstant: questionViewController.contentHeight)
        ])
    }
    
    private func addAnswersViewController() {
        addChild(answersViewController)
        let answersView = answersViewController.view!
        scrollContentView.addSubview(answersView)
        answersViewController.didMove(toParent: self)
        
        answersView.translatesAutoresizingMaskIntoConstraints = false
        
        let topInset: CGFloat = 4
        let contentHeight = topInset + questionViewController.contentHeight + barsHeight
        let collectionHeight = UIScreen.main.bounds.height - contentHeight
        
        NSLayoutConstraint.activate([
            answersView
                .topAnchor
                .constraint(equalTo: questionViewController.view.bottomAnchor,
                            constant: topInset),
            answersView
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            answersView
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            answersView
                .bottomAnchor
                .constraint(equalTo: scrollContentView.bottomAnchor),
            answersView
                .heightAnchor
                .constraint(equalToConstant: collectionHeight)
        ])
    }
}
