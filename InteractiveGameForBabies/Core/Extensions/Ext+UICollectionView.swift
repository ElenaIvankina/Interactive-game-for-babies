//
//  CollectionView+Helper.swift
//  AlbumCovers
//
//  Created by Роман Мироненко on 07.02.2021.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(registerClass: T.Type) {
        let defaultReuseIdentifier = registerClass.defaultReuseIdentifier
        register(registerClass, forCellWithReuseIdentifier: defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func configureGridLayout(rowCount count: Int, itemInset inset: CGFloat = 4) {
        let columnCount:CGFloat = 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / columnCount),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: inset,
                                   leading: inset,
                                   bottom: inset,
                                   trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0 / CGFloat(count)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionViewLayout = layout
    }
    
    func configureDragLiftGesture(minimumPressDuration duration: TimeInterval) {
        gestureRecognizers?.forEach {
            if(String(describing: type(of: $0)) == "_UIDragLiftGestureRecognizer"),
              let longGesture = $0 as? UILongPressGestureRecognizer {
                longGesture.minimumPressDuration = duration
            }
        }
    }
}

extension UICollectionViewCell: ReusableView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

