//
//  GameMenuViewController.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import UIKit

class GameMenuViewController: UIViewController {
    
    private let gameVCBuilder = GameViewControllerBuilder()
    
    // MARK: - Views
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, малыш! 👋"
        label.textAlignment = .center
        label.textColor = .mainText
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери игру"
        label.textAlignment = .center
        label.textColor = .mainText
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.dragInteractionEnabled = true
        
        collectionView.register(registerClass: GameCell.self)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    private func setBackgroundView() {
        setGradientBackground()
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "menu_bg")
        imageView.center = self.view.center
        view.addSubview(imageView)
        view.bringSubviewToFront(imageView)
    }
    
    private enum Constants {
        static let topInset: CGFloat = 64
        static let minInset: CGFloat = 4
        static let spaceInset: CGFloat = 8
        static let collectionTopInset: CGFloat = 32
    }
    
    private func setupViews() {
        setBackgroundView()
        setupHeaderLabel()
        setupSubLabel()
        setupCollectionView()
    }
    
    private func setupHeaderLabel() {
        view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel
                .topAnchor
                .constraint(equalTo: view.topAnchor,
                            constant: Constants.topInset),
            headerLabel
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            headerLabel
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSubLabel() {
        view.addSubview(subLabel)
        
        NSLayoutConstraint.activate([
            subLabel
                .topAnchor
                .constraint(equalTo: headerLabel.bottomAnchor,
                            constant: Constants.spaceInset),
            subLabel
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            subLabel
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        let heightConstraint = collectionView
            .heightAnchor
            .constraint(equalToConstant: 320)
        heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            collectionView
                .topAnchor
                .constraint(greaterThanOrEqualTo: subLabel.bottomAnchor,
                            constant: Constants.collectionTopInset),
            collectionView
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor,
                            constant: Constants.minInset),
            collectionView
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor,
                            constant: -Constants.minInset),
            collectionView
                .bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                            constant: Constants.spaceInset),
            heightConstraint
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let rowCount = lround(Double(TypeOfGame.allCases.count) / 2.0)
        collectionView.configureGridLayout(rowCount: rowCount)
    }
}

extension GameMenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TypeOfGame.allCases.count
    }
}

extension GameMenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GameCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(at: indexPath)
        cell.delegate = self
        return cell
    }
}

extension GameMenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let typeOfGame = TypeOfGame.init(rawValue: indexPath.row) else { return }
        navigationController?.pushViewController(gameVCBuilder.buildGame(typeOfGame: typeOfGame), animated: true)
    }
}

extension GameMenuViewController: GameCellDelegate {
    
    func didTapButtonInCell(forGame index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

