//
//  GameCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 26.06.2022.
//

import UIKit

protocol GameCellDelegate: AnyObject {
    func didTapButtonInCell(forGame index: Int)
}

class GameCell: UICollectionViewCell {
    
    private struct gameInfo {
        let name: String
        let image: UIImage?
    }
        
    weak var delegate: GameCellDelegate?
    
    private var startGameButton: StartGameButton = {
        let button = StartGameButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bgColor = .gameButton
        button.layer.cornerRadius = 20
        // button.layer.borderWidth = 1
        button.borderColor = .gameButtonBorder
        return button
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.textColor = .gameNameText
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()

        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(at indexPath: IndexPath) {
        let typeOfGame = TypeOfGame.allCases[indexPath.row]
        
        startGameButton.image = typeOfGame.image
        startGameButton.tag = typeOfGame.rawValue
        startGameButton.addTarget(self,
                                  action: #selector(handleGameButton),
                                  for: .touchUpInside)
        
        nameLabel.text = typeOfGame.name
    }
    
    private enum Constants {
        static let buttonSize: CGSize = CGSize(width: 100, height: 100)
        static let shortInset: CGFloat = 4
        static let midInset: CGFloat = 8
        static let longInset: CGFloat = 16
    }
    
    private func setupView() {
        contentView.addSubview(startGameButton)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            startGameButton
                .heightAnchor
                .constraint(equalToConstant: Constants.buttonSize.height),
            startGameButton
                .widthAnchor
                .constraint(equalToConstant: Constants.buttonSize.width),
            startGameButton
                .centerXAnchor
                .constraint(equalTo: contentView.centerXAnchor),
            startGameButton
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: Constants.shortInset),
            startGameButton
                .bottomAnchor
                .constraint(equalTo: nameLabel.topAnchor,
                            constant: -Constants.midInset),

            nameLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: Constants.longInset),
            nameLabel
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: -Constants.longInset)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        startGameButton.image = nil
    }
    
    @objc private func handleGameButton() {
        delegate?.didTapButtonInCell(forGame: startGameButton.tag)
    }
}
