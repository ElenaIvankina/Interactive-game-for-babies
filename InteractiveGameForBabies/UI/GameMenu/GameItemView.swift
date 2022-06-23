//
//  GameItemView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 14.06.2022.
//

import SwiftUI

class GameItemView: UIView {

    // MARK: - Subviews
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

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func configure(name: String, image: UIImage?) {
        nameLabel.text = name
        startGameButton.image = image
    }

    func addButtonTarget(target: Any?, action: Selector, typeOfGame: TypeOfGame) {
        startGameButton.tag = typeOfGame.rawValue
        startGameButton.addTarget(target,
                                  action: action,
                                  for: .touchUpInside)
    }

    // MARK: - Private methods
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
}

struct GameView_Preview: PreviewProvider {
    static var previews: some View {
        let view = GameItemView()
        view.configure(name: "Как говорят животные",
                       image: UIImage(named: "notes"))

        return UIPreviewView(view)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)

    }
}
