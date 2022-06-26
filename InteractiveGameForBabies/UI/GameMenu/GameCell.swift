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
    
    private let gamesData = [
        gameInfo(name: "Как говорят животные",
                 image: UIImage(named: "notes")),
        gameInfo(name: "Один - много",
                 image: UIImage(named: "many")),
        gameInfo(name: "Изучаем цвета",
                 image: UIImage(named: "colors")),
        gameInfo(name: "Лягушки и фигуры",
                 image: UIImage(named: "figures"))
    ]
    
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
        let data = gamesData[indexPath.row]
        
        startGameButton.image = data.image
        startGameButton.tag = indexPath.row
        startGameButton.addTarget(self,
                                  action: #selector(handleGameButton),
                                  for: .touchUpInside)
        
        nameLabel.text = data.name
    }
    
    private func setupView() {
        addSubview(startGameButton)
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            startGameButton
                .heightAnchor
                .constraint(equalToConstant: 100),
            startGameButton
                .widthAnchor
                .constraint(equalToConstant: 100),
            startGameButton
                .centerXAnchor
                .constraint(equalTo: centerXAnchor),
            startGameButton
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: 10),
            startGameButton
                .bottomAnchor
                .constraint(equalTo: nameLabel.topAnchor,
                            constant: -10),

            nameLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: 15),
            nameLabel
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: -15)
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
