//
//  GameAnswersView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI

class GameAnswersView: UIView {
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.dragInteractionEnabled = true
        
        collectionView.register(registerClass: AnswerCell.self)
        
        return collectionView
    }()
    
    private weak var delegate: GameDelegate?
    
    private let isAnimation = true
    private var figureCardIndexes = Array(0...3)
    private let animation = Animation()
    private let durationRightAnswer: CFTimeInterval = 0.6
    private let durationWrongAnswer: CFTimeInterval = 0.4
    
    private enum Constants {
        static let inset: CGFloat = 4
        static let itemInset: CGFloat = 2
        static let sectionInset: CGFloat = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private var sectionsCount = 0
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(delegate: GameDelegate) {
        self.delegate = delegate
        
        switch delegate.gameViewController?.typeOfGame {
        case .figureGame:
            configureSectionsLayout()
            sectionsCount = 2
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
        default:
            configureGridLayout()
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
    
    private func configureSectionsLayout() {
        enum Section: Int, CaseIterable {
            case figures
            case answers
            
            var columnCount: Int {
                switch self {
                case .figures:
                    return 4
                case .answers:
                    return 2
                }
            }
        }
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let columns = sectionKind.columnCount
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: Constants.itemInset,
                                       leading: Constants.itemInset,
                                       bottom: Constants.itemInset,
                                       trailing: Constants.itemInset)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0 / 3.2)) // <--- crutch
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: Constants.sectionInset,
                                          leading: Constants.sectionInset,
                                          bottom: Constants.sectionInset,
                                          trailing: Constants.sectionInset)
            
            return section
        }
        
        collectionView.collectionViewLayout = layout
    }
    
    private func configureGridLayout() {
        let columnCount:CGFloat = 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / columnCount),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: Constants.itemInset,
                                   leading: Constants.itemInset,
                                   bottom: Constants.itemInset,
                                   trailing: Constants.itemInset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0 / 3.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionView.collectionViewLayout = layout
    }
    
    
    private func checkAnswer(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        guard let item = coordinator.items.first,
              let sourceIndexPath = item.sourceIndexPath,
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
                delegate?.handlingRightAnswer()
            },
                                               completion: nil)
        }
        
        if let cell = collectionView.cellForItem(at: destinationIndexPath) as? AnswerCell {
            switch isRightAnswer {
            case true:
                cell.animationCahgeImageAndFlip(card: destinationCard, duration: durationRightAnswer)
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
        guard let resultCheck = delegate?.checkingAnswer(answerCard: selectedCard) else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnswerCell else { return }
        
        if resultCheck {
            cell.animateRightAnswer(duration: durationRightAnswer)
            cell.isUserInteractionEnabled = false
        } else {
            cell.animateWrongAnswer(duration: durationWrongAnswer)
        }
    }
}
