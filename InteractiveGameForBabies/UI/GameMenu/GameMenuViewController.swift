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
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери игру"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackView: UIStackView = {

        struct gameInfo {
            let name: String
            let image: UIImage?
            let typeOfGame: TypeOfGame
        }

        let gamesData = [
            gameInfo(name: "Как говорят животные",
                     image: UIImage(named: "notes"),
                     typeOfGame: .speakAnimalGame),
            gameInfo(name: "Один - много",
                     image: UIImage(named: "many"),
                     typeOfGame: .countGame),
            gameInfo(name: "Изучаем цвета",
                     image: UIImage(named: "colors"),
                     typeOfGame: .colorGame),
            gameInfo(name: "Лягушки и фигуры",
                     image: UIImage(named: "figures"),
                     typeOfGame: .figureGame)
        ]

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5

        let rows = 2
        let columns = 2

        for row in 0 ..< rows {
            let stackViewH = UIStackView()
            stackViewH.axis = .horizontal
            stackViewH.alignment = .fill
            stackViewH.distribution = .fillEqually
            stackViewH.spacing = 5

            for col in 0 ..< columns {
                let index = row * columns + col
                let gameInfo = gamesData[index]

                let view = GameItemView()
                view.configure(name: gameInfo.name, image: gameInfo.image)
                view.addButtonTarget(target: self, action: #selector(selectGameButton), typeOfGame: gameInfo.typeOfGame)

                stackViewH.addArrangedSubview(view)
            }

            stackView.addArrangedSubview(stackViewH)
        }

        return stackView
    }()

    private func setBackgroundView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.5790637732, green: 0.6192606091, blue: 0.9909513593, alpha: 1).cgColor, #colorLiteral(red: 0.2345913351, green: 0.7455343008, blue: 0.9952169061, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(gradientLayer)

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
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            headerLabel
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            headerLabel
                .topAnchor
                .constraint(equalTo: view.topAnchor,
                            constant: 50),
            headerLabel
                .widthAnchor
                .constraint(equalTo: view.widthAnchor,
                            multiplier: 1),
            headerLabel
                .heightAnchor
                .constraint(equalTo: view.heightAnchor,
                            multiplier: 0.1),

            subLabel
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            subLabel
                .topAnchor
                .constraint(equalTo: headerLabel.bottomAnchor,
                            constant: 10),
            subLabel
                .widthAnchor
                .constraint(equalTo: view.widthAnchor,
                            multiplier: 1),

            stackView
                .topAnchor
                .constraint(greaterThanOrEqualTo: subLabel.bottomAnchor,
                            constant: 5),
            stackView
                .leftAnchor
                .constraint(equalTo: view.leftAnchor,
                            constant: 5),
            stackView
                .rightAnchor
                .constraint(equalTo: view.rightAnchor,
                            constant: -5),
            stackView
                .bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                            constant: 10),
            stackView
                .heightAnchor
                .constraint(equalToConstant: 320)
        ])
    }

    @objc
    func selectGameButton(sender: AnyObject) {
        guard let btn = sender as? UIButton else { return }
        let tag = btn.tag
        guard let typeOfGame = TypeOfGame.init(rawValue: tag) else { return }
        navigationController?.pushViewController(gameVCBuilder.buildGame(typeOfGame: typeOfGame), animated: true)
    }
}
