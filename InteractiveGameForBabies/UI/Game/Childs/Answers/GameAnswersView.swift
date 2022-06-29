//
//  GameAnswersView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI

class GameAnswersView: UIView {
    
    private let isAnimation = true
    private let animation = Animation()
    private let durationRightAnswer: CFTimeInterval = 0.6
    private let durationWrongAnswer: CFTimeInterval = 0.4
    
    private var figureCardIndexes = Array(0...3)
    private var sectionsCount = 0
    
    private enum Constants {
        static let inset: CGFloat = 4
        static let itemInset: CGFloat = 2
        static let sectionInset: CGFloat = 10
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.dragInteractionEnabled = true
        
        collectionView.register(registerClass: AnswerCell.self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate() {

        let answerRowCount = lround(Double(GameSession.shared.currentRandomCards.count) / 2.0)
        
        guard let gameViewController = GameSession.shared.gameViewController as? GameViewController else { return }
        
        switch gameViewController.typeOfGame {
        case .figureGame:
            let figuresCount = GameSession.shared.currentRandomCards.count
            collectionView.configureSectionsLayout(columnCount: [figuresCount, 2], rowCount: [1, answerRowCount])
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
            collectionView.isScrollEnabled = false
            collectionView.configureDragLiftGesture(minimumPressDuration: 0.01)
            sectionsCount = 2
        default:
            collectionView.configureGridLayout(rowCount: answerRowCount)
            sectionsCount = 1
        }
    }
    
    func reloadCollectionView () {
        self.collectionView.reloadData()
        self.collectionView.performBatchUpdates(nil) { result in
            self.animationCollectionView(isAfterReload: true, duration: 0.6)
        }
        figureCardIndexes = Array(0...3)
    }
    
    func animationCollectionView(isAfterReload: Bool, duration: CFTimeInterval) {
        let fromValue = isAfterReload ? 0 : 1
        let toValue = isAfterReload ? 1 : 0
        animation.transformAnimation(view: collectionView, duration: duration)
        animation.changeAlphaAnimation(view: collectionView, fromValue: fromValue, toValue: toValue, duration: duration)
    }
    
    private func setupView() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: Constants.inset),
            collectionView
                .bottomAnchor
                .constraint(equalTo: bottomAnchor,
                            constant: -Constants.inset),
            collectionView
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: -Constants.inset),
            collectionView
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: Constants.inset)
        ])
    }
    
    private func checkAnswer(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        guard let item = coordinator.items.first,
              let sourceIndexPath = item.sourceIndexPath,
              sourceIndexPath.section != destinationIndexPath.section,
              let figureQuestion = GameSession.shared.currentQuestion as? FigureQuestion
        else {
            return
        }
        
        let sourceCardId = figureCardIndexes[sourceIndexPath.row]
        let sourceCard = figureQuestion.cardsFigure[sourceCardId]
        let destinationCard = GameSession.shared.currentRandomCards[destinationIndexPath.row]
        var isRightAnswer = false
        
        if sourceCard.isEqualTo(destinationCard) {
            isRightAnswer = true
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [sourceIndexPath])
                figureCardIndexes.remove(at: sourceIndexPath.row)
                guard let gameViewController = GameSession.shared.gameViewController as? GameViewController else { return }
                gameViewController.gameWorker.handlingRightAnswer()
            },
                                               completion: nil)
        }
        
        if let cell = collectionView.cellForItem(at: destinationIndexPath) as? AnswerCell {
            switch isRightAnswer {
            case true:
                cell.animationChangeImageAndFlip(card: destinationCard, duration: durationRightAnswer)
            case false:
                cell.animateWrongAnswer(duration: durationWrongAnswer)
            }
        }
    }
}

extension GameAnswersView: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0,
           let figureQuestion = GameSession.shared.currentQuestion as? FigureQuestion {
            return figureQuestion.cardsFigure.count - GameSession.shared.counterOfRightAnswers
        }
        
        return GameSession.shared.currentRandomCards.count
    }
}

extension GameAnswersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var card: CardProtocol = GameSession.shared.currentRandomCards[indexPath.row]
        
        if indexPath.section == 0,
           let figureQuestion = GameSession.shared.currentQuestion as? FigureQuestion {
            card = figureQuestion.cardsFigure[indexPath.row]
        }
        
        let cell: AnswerCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: card)
        
        return cell
    }
}

extension GameAnswersView: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.section == 0  else { return [] }
        
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: "\(indexPath.row)" as NSString))
        return [dragItem]
    }
}

extension GameAnswersView: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard collectionView.hasActiveDrag else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        
        return UICollectionViewDropProposal(operation: .move, intent: .unspecified)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath,
              coordinator.proposal.operation == .move
        else {
            return
        }
        
        checkAnswer(coordinator: coordinator,
                    destinationIndexPath: destinationIndexPath,
                    collectionView: collectionView)
    }
}

extension GameAnswersView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.numberOfSections < 2 else { return }
        
        let selectedCard = GameSession.shared.currentRandomCards[indexPath.row]
        guard let gameViewController = GameSession.shared.gameViewController as? GameViewController else { return }
        let resultCheck = gameViewController.gameWorker.checkingAnswer(answerCard: selectedCard)
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnswerCell else { return }
        
        if resultCheck {
            cell.animateRightAnswer(duration: durationRightAnswer)
            cell.isUserInteractionEnabled = false
        } else {
            cell.animateWrongAnswer(duration: durationWrongAnswer)
        }
    }
}

extension UICollectionView {
    
    func configureSectionsLayout(columnCount columns: [Int],
                                 rowCount rows: [Int],
                                 itemInset inset: CGFloat = 4,
                                 groupSpacing spacing: CGFloat = 8) {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            
            switch sectionIndex {
            case 0:
                return self.createFigureSection(columns: columns[sectionIndex],
                                                itemInset: inset,
                                                groupSpacing: spacing)
            case 1:
                return self.createAnswersSection(columns: columns[sectionIndex],
                                                 rows: rows[sectionIndex],
                                                 itemInset: inset,
                                                 groupSpacing: spacing)
            default:
                return nil
            }
        }
        
        collectionViewLayout = layout
    }
    
    private func createFigureSection(columns: Int,
                                     itemInset: CGFloat,
                                     groupSpacing: CGFloat) -> NSCollectionLayoutSection {
        let widthDimension = NSCollectionLayoutDimension.fractionalWidth(1.0 / CGFloat(columns))
        
        let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension,
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemInset,
                                   leading: itemInset,
                                   bottom: itemInset,
                                   trailing: itemInset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: widthDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = groupSpacing
        
        return section
    }
    
    private func createAnswersSection(columns: Int,
                                      rows: Int,
                                      itemInset: CGFloat,
                                      groupSpacing: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: itemInset,
                                   leading: itemInset,
                                   bottom: itemInset,
                                   trailing: itemInset)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / (CGFloat(rows) + 0.5))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = groupSpacing
        
        return section
    }
}
