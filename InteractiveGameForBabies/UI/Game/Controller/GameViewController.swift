//
//  GameViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    private var mediaType: MediaType
    
    //MARK: - Views
    lazy var questionViewController = GameQuestionViewController(type: mediaType)
    lazy var answersViewController = GameAnswersViewController()
    
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
    
    init(type: MediaType) {
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
    }
    
    private func configureScrollView() {
        scrollView.addSubview(scrollContentView)
        view.addSubview(scrollView)
        
        let heightConstraint = scrollContentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            scrollContentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }
    
    private func addQuestionViewController() {
        addChild(questionViewController)
        let questionView = questionViewController.view!
        scrollContentView.addSubview(questionView)
        questionViewController.didMove(toParent: self)
        
        questionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: scrollContentView.topAnchor),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func addAnswersViewController() {
        addChild(answersViewController)
        let answersView = answersViewController.view!
        scrollContentView.addSubview(answersView)
        answersViewController.didMove(toParent: self)
        
        answersView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answersView.topAnchor.constraint(equalTo: questionViewController.view.bottomAnchor, constant: 32),
            answersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            answersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            answersView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor),
            answersView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

