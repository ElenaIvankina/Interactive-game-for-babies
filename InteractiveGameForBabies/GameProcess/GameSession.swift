//
//  GameSession.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

protocol GameSessionProtocol {
    
    var questionsArray: [QuestionProtocol] { get set }
    var cardsArray: [CardProtocol] { get set }
    var numberOfCardsInSession: Int { get set }
    var currentQuestion: QuestionProtocol { get set }
    var currentRandomCards: [CardProtocol] { get }
    var numberOfRightAnswers: Int { get }
    var counterOfRightAnswers: Int { get set }
}

class GameSession: GameSessionProtocol {

    static let shared = GameSession()
    
    private init() {}
    
    var questionsArray: [QuestionProtocol] = []
    var cardsArray: [CardProtocol] = []
    
    var numberOfCardsInSession = 6
    
    //TODO убрать здесь значение, сделать опционалом
    var currentQuestion: QuestionProtocol = AnimalQuestion(card: AnimalCard(imageName: "animal1",
                                                                            animal: .camel,
                                                                            sound: ""))
    
    var currentRandomCards: [CardProtocol] = []

    var gameViewController: GameViewControllerProtocol?
    
    var numberOfRightAnswers = 0

    var counterOfRightAnswers: Int = 0 {
        didSet {
            if counterOfRightAnswers == numberOfRightAnswers && counterOfRightAnswers != 0 {
                guard let vc = self.gameViewController as? GameViewController else {return}
                
                let duration = 0.6
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    vc.answersViewController.gameAnswersView.animationCollectionView(isAfterReload: false, duration: duration)
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + duration * 1.5) {
                    vc.gameWorker.newGame(viewController: vc)
                }

        }
    }
    }
    
    func getRandomQuestion(questionsArray: [QuestionProtocol]) -> QuestionProtocol {
        if let randomQuestion = questionsArray.randomElement() {
            return randomQuestion
        } else {
            return AnimalQuestion(card: AnimalCard(imageName: "animal1",
                                                   animal: .camel,
                                                   sound: ""))
        }
    }
    
    func getRandomCards(cardsArray: [CardProtocol]) -> [CardProtocol] {
        return cardsArray.randomElements(sample: currentQuestion.card,
                                         countElements: numberOfCardsInSession)
    }
    
    func countRightAnswers(sample: CardProtocol, cards: [CardProtocol]) -> Int {
        var count = 0
        
        cards.forEach {
            if $0.isEqualTo(sample) {
                count += 1
            }
        }
        
        return count
    }
    
    func findFigureAnswerToQuestion() -> [CardProtocol] {
        var arr: [CardProtocol] = []
        guard let figureQuestion = GameSession.shared.currentQuestion as? FigureQuestion else { return arr}
        for card in figureQuestion.cardsFigure {
            if let figureCard = GameSession.shared.cardsArray.first(where: { $0.isEqualTo(card) }) {
                arr.append(figureCard)
            }
        }
        return arr.shuffled()
    }
}
