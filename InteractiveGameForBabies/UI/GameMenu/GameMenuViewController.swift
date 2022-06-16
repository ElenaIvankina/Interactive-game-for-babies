//
//  GameMenuViewController.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import UIKit

class GameMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        
        
        
        let lAnCard = AnimalCard(imageName: "tst1")
        let rAnCard = AnimalCard(imageName: "tst2")

        let lCount = CountCard(imageName: "tstw3", count: .one)
        let rCount = CountCard(imageName: "tstw4", count: .many)


        print("== \(lAnCard == rAnCard)")
        print("== \(lAnCard == lCount)")
        print("== \(lCount == rCount)")

        let arr: [CardProtocol] = [lAnCard, rAnCard, lCount, rCount]

        let tstC = CountCard(imageName: "qwerty", count: .many)
        let resArr = arr.filter() {$0 == tstC}

        for i in resArr {
            print(i.imageName)
        }
    }
    
    //MARK: - Views
    
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
            let action: Selector
        }
        
        let gamesData = [
            gameInfo(name: "Как говорят животные",
                     image: UIImage(named: "notes"),
                     action: #selector(gameAnimalsButtonTapped)),
            gameInfo(name: "Один - много",
                     image: UIImage(named: "many"),
                     action: #selector(gameAmountButtonTapped)),
            gameInfo(name: "Изучаем цвета",
                     image: UIImage(named: "colors"),
                     action: #selector(gameColorsButtonTapped)),
            gameInfo(name: "Лягушки и фигуры",
                     image: UIImage(named: "figures"),
                     action: #selector(gameFiguresButtonTapped))
        ]
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
                view.addButtonTarget(target: self, action: gameInfo.action)
                
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
    
    @objc func gameAnimalsButtonTapped() {
        //TODO убрать принт
        print("Переход к игре КАК ГОВОРЯТ ЖИВОТНЫЕ")
        self.navigationController?.pushViewController(SpeakAnimalGameViewController(), animated: true)
    }
    
    @objc func gameAmountButtonTapped() {
        //TODO убрать принт
        print("Переход к игре ОДИН - МНОГО")
        self.navigationController?.pushViewController(
            CountGameViewController(countQuestion:
                                        CountQuestion(
                                            card: CountCard(imageName: "one0", count: .one),
                                            questionText: "Нажми на все картинки, где предмет один")),
            animated: true)
    }
    
    @objc func gameColorsButtonTapped() {
        print("Переход к игре ИЗУЧАЕМ ЦВЕТА")
    }
    
    @objc func gameFiguresButtonTapped() {
        print("Переход к игре ЛЯГУШКИ И ФИГУРЫ")
    }
}
