//
//  GameMenuViewController.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import UIKit

class GameMenuViewController: UIViewController {
    let gameVCBuilder = GameViewControllerBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    // MARK: - Views
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, малыш! 👋"
        label.textAlignment = .center
        label.textColor = .mainText
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel: UILabel = {
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
    
    private func setupUI() {
        setBackgroundView()
        
        view.addSubview(headerLabel)
        view.addSubview(subLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            headerLabel
                .topAnchor
                .constraint(equalTo: view.topAnchor,
                            constant: 48),
            headerLabel
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            headerLabel
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            
            
            subLabel
                .topAnchor
                .constraint(equalTo: headerLabel.bottomAnchor,
                            constant: 16),
            subLabel
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            subLabel
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            
            collectionView
                .topAnchor
                .constraint(equalTo: subLabel.bottomAnchor,
                            constant: 32),
            collectionView
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor,
                            constant: 4),
            collectionView
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor,
                            constant: -4),
            collectionView
                .bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                            constant: 4),
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let rowCount = lround(Double(TypeOfGame.allCases.count) / 2.0)
        collectionView.configureGridLayout(rowCount: rowCount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

extension GameMenuViewController: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
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

