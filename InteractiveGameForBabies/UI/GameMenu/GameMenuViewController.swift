//
//  GameMenuViewController.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import UIKit
import SwiftUI

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
    
    let gameViews = [
        GameView()
    ]
    
    private func setupUI() {
        self.view.addSubview(headerLabel)
        self.view.addSubview(subLabel)
        
        for game in gameViews {
            self.view.addSubview(game)
        }
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15),
            headerLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            headerLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            
            subLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            subLabel.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15),
            subLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            subLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
        ])
    }
    
    //Наверху
    //UILabel Привет, малыш!
    //под ним UILabel Выбери игру
    //под ними слева 4 кнопки с названием игр : Как говорят животные, Изучаем цвета, Один - много, Лягушки и фигуры
    //под ними справа красивая картинка типа винни пуха
    
    
    
    
}

class GameView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 3
        label.textColor = .label
        return label
    }()
    
    private lazy var addToBasketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "cart.fill.badge.plus"),
                        for: .normal)
        return button
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    func configure(name: String) {
        self.nameLabel.text = name
    }
    
    // MARK: - Private methods
    private func setupView() {
        //self.addSubview(nameLabel)
        self.addSubview(addToBasketButton)
        
        NSLayoutConstraint.activate([
            addToBasketButton
                .heightAnchor
                .constraint(equalToConstant: 100),
            addToBasketButton
                .widthAnchor
                .constraint(equalToConstant: 100),
            addToBasketButton
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor,
                            constant: 15),
            addToBasketButton
                .topAnchor
                .constraint(equalTo: self.topAnchor,
                            constant: 10),
        ])
    }
}

struct GameView_Preview: PreviewProvider {
    static var previews: some View {
        let view = GameView()
        view.configure(name: "Как говорит")
        
        return UIPreviewView(view)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
