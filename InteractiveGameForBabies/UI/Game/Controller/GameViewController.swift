//
//  GameViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Views
    lazy var questionViewController = GameQuestionViewController()
    lazy var answersViewController = GameAnswersViewController()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
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
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .never
    }
    
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
            questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
            answersView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
}

