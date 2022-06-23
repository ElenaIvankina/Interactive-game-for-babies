//
//  AnswersCollectionViewLayout.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 18.06.2022.
//

import UIKit

class AnswersCollectionViewLayout: UICollectionViewLayout {

    private enum Constants {
        static let numberOfColumns = 2
        static let cellInset: CGFloat = 4
    }

    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    private var cache: [UICollectionViewLayoutAttributes] = []

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        guard cache.isEmpty == true,
              let collectionView = collectionView
        else {
            return
        }

        let columnWidth = contentWidth / CGFloat(Constants.numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<Constants.numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: Constants.numberOfColumns)

        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let rowHeight = collectionView.bounds.height / ceil(CGFloat(numberOfItems) / 2)

        for item in 0..<numberOfItems {
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: rowHeight)
            let insetFrame = frame.insetBy(dx: Constants.cellInset,
                                           dy: Constants.cellInset)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: item, section: 0))
            attributes.frame = insetFrame
            cache.append(attributes)
            yOffset[column] = yOffset[column] + rowHeight
            column = column < (Constants.numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }

        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
