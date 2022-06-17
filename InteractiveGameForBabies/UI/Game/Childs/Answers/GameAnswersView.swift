//
//  GameAnswersView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI

class GameAnswersView: UIView {
    
    private(set) var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(AnswerCell.self, forCellWithReuseIdentifier: AnswerCell.reuseId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.isUserInteractionEnabled = true
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
    
    // MARK: - Private
    
    private func setupView() {
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCell.reuseId, for: indexPath) as! AnswerCell
        
        let image = self.cardImages[indexPath.row]
        cell.configure(with: image)
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 10
        
        return cell
    }
}

extension GameAnswersView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = collectionView.contentInset

        var width = collectionView.bounds.width - (insets.right + insets.left)
        var height = collectionView.bounds.height - (insets.top + insets.bottom)

        width /= 2
        height /= ceil(CGFloat(cardImages.count) / 2)
        
        return .init(width: width - 4, height: height - 4)
    }
    
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
        view.collectionView.reloadData()
        return UIPreviewView(view)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
