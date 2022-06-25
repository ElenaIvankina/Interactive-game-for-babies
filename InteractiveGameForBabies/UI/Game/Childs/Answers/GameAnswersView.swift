//
//  GameAnswersView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI

class GameAnswersView: UIView {
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: AnswersCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        
        collectionView.register(registerClass: AnswerCell.self)

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
}

extension GameAnswersView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameSession.shared.currentRandomCards.count
    }
}

extension GameAnswersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnswerCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: GameSession.shared.currentRandomCards[indexPath.row])
        return cell
    }
}

extension GameAnswersView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
