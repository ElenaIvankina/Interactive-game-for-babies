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
        collectionView.backgroundColor = .white
        collectionView.isUserInteractionEnabled = true
        
        collectionView.register(AnswerCell.self, forCellWithReuseIdentifier: AnswerCell.reuseId)
        
        return collectionView
    }()
    
    var cardImages = [UIImage?]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
        ])
    }
}

extension GameAnswersView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardImages.count
    }
}

extension GameAnswersView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCell.reuseId, for: indexPath) as? AnswerCell else {
            fatalError("Cell for item at \(indexPath) has not been implemented")
        }
        
        cell.configure(with: cardImages[indexPath.row])
        
        return cell
    }
}

extension GameAnswersView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO check card
        print("cell clicked at \(indexPath)")
    }
}

struct GameAnswersView_Preview : PreviewProvider {
    static var previews: some View {
        let view = GameAnswersView()
        view.cardImages = [
            UIImage(named: "animal1"),
            UIImage(named: "animal2"),
            UIImage(named: "animal3"),
            UIImage(named: "animal4"),
            UIImage(named: "animal5"),
            UIImage(named: "animal6")
        ]
        return UIPreviewView(view)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 375, height: 300.0))
    }
}
