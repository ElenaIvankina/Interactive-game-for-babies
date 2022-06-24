//
//  GameFiguresAnswersView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI

class GameFiguresAnswersView: UIView {
    
    enum Section: Int, CaseIterable {
        case questions
        case answers
        
        var columnCount: Int {
            switch self {
            case .questions:
                return 4
            case .answers:
                return 2
            }
        }
    }
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let columns = sectionKind.columnCount
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let groupHeight = columns == 1 ?
            NSCollectionLayoutDimension.absolute(44) :
            NSCollectionLayoutDimension.fractionalWidth(0.5)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0 / 4.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.dragInteractionEnabled = true
        
        collectionView.register(AnswerCell.self, forCellWithReuseIdentifier: AnswerCell.reuseId)
        
        return collectionView
    }()
    
    private weak var delegate: GameDelegate?
    
    private enum Constants {
        static let inset: CGFloat = 4
    }
    
    private let isAnimation = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(delegate: GameDelegate) {
        self.delegate = delegate
    }
    
    func reloadCollectionView () {
        self.collectionView.reloadData()
        self.collectionView.performBatchUpdates(nil) { result in
            self.animationCell(isAfterReload: true)
        }
    }
    
    func animationCell(isAfterReload: Bool) {
        if !isAnimation { return }
        for cell in collectionView.subviews {
            Animation.transformAnimation(view: cell)
            let fromValue = isAfterReload ? 0 : 1
            let toValue = isAfterReload ? 1 : 0
            Animation.changeAlphaAnimation(view: cell, fromValue: fromValue, toValue: toValue)
        }
    }
    
    let testData = [ Array(repeating: UIImage(named: "circleQ"), count: 4), Array(repeating: UIImage(named: "circleA"), count: 4) ]
    
    private func setupView() {
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        
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
    
    private func compareItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath {
            // TODO check answer
            print("Compare figure at \(sourceIndexPath) with frog at \(destinationIndexPath)")
        }
    }
}

extension GameFiguresAnswersView: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testData[section].count
    }
}

extension GameFiguresAnswersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCell.reuseId, for: indexPath) as? AnswerCell else {
            fatalError("Cell for item at \(indexPath) has not been implemented")
        }
        
        cell.configure(with: testData[indexPath.section][indexPath.row])
        
        return cell
    }
}

extension GameFiguresAnswersView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1  else { return }
        
        let selectCard = GameSession.shared.currentRandomCards[indexPath.row]
        guard let resultCheck = delegate?.checkingAnswer(answerCard: selectCard) else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnswerCell else { return }
        if resultCheck {
            cell.animateRightAnswer()
            cell.isUserInteractionEnabled = false
        } else {
            cell.animateWrongAnswer()
        }
    }
}

extension GameFiguresAnswersView: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.section == 0  else { return [] }
        
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: "\(indexPath.row)" as NSString))
        return [dragItem]
    }
}

extension GameFiguresAnswersView: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .unspecified)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        guard let destinationIndexPath = coordinator.destinationIndexPath,
              coordinator.proposal.operation == .move
        else {
            return
        }
        
        compareItems(coordinator: coordinator,
                     destinationIndexPath: destinationIndexPath,
                     collectionView: collectionView)
    }
}
