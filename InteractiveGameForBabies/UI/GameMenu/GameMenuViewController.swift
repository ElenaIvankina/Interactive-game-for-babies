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
    }
    
    //MARK: - Views
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, малыш! 👋"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери игру"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let stackView: UIStackView = {
        
        let gamesNames = [
            "Как говорят животные",
            "Один - много",
            "Изучаем цвета",
            "Лягушки и фигуры"
        ]
        
        let gamesImages = [
            UIImage(named: "notes"),
            UIImage(named: "many"),
            UIImage(named: "colors"),
            UIImage(named: "figures")
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
                
                let view = GameItemView()
                view.configure(name: gamesNames[index], image: gamesImages[index])
                
                stackViewH.addArrangedSubview(view)
            }
            
            stackView.addArrangedSubview(stackViewH)
        }
        
        return stackView
    }()
    
    private func setBackgroundImage() {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "menu_bg")
        imageView.center = self.view.center
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    private func setupUI() {
        setBackgroundImage()
        
        self.view.addSubview(headerLabel)
        self.view.addSubview(subLabel)
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            headerLabel
                .leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor),
            headerLabel
                .topAnchor
                .constraint(equalTo: self.view.topAnchor,
                            constant: 15),
            headerLabel
                .widthAnchor
                .constraint(equalTo: self.view.widthAnchor,
                            multiplier: 1),
            headerLabel
                .heightAnchor
                .constraint(equalTo: self.view.heightAnchor,
                            multiplier: 0.1),
            
            subLabel
                .leadingAnchor
                .constraint(equalTo: self.view.leadingAnchor),
            subLabel
                .topAnchor
                .constraint(equalTo: self.headerLabel.bottomAnchor,
                            constant: 15),
            subLabel
                .widthAnchor
                .constraint(equalTo: self.view.widthAnchor,
                            multiplier: 1),
            subLabel
                .heightAnchor
                .constraint(equalTo: self.view.heightAnchor,
                            multiplier: 0.1),
            
            stackView
                .topAnchor
                .constraint(equalTo: subLabel.bottomAnchor,
                            constant: 5),
            stackView
                .leftAnchor
                .constraint(equalTo: self.view.leftAnchor,
                            constant: 5),
            stackView
                .rightAnchor
                .constraint(equalTo: self.view.rightAnchor,
                            constant: -5),
            stackView
                .bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor,
                            constant: -5)
        ])
    }
}
