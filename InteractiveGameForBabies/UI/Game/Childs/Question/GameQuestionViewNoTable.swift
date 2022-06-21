//
//  GameQuestionViewNoTable.swift
//  InteractiveGameForBabies
//
//  Created by Павел Черняев on 21.06.2022.
//

import Foundation
import UIKit

class GameQuestionView: UIView {
    let typeOfGame: TypeOfGame
    
    
    init?(typeOfGame: TypeOfGame) {
        self.typeOfGame = typeOfGame
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func addUILabel(text: String) {
        let label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addUIImageView(named: String) {
        let image = UIImage(named: named)
        let imageView = UIImageView(image: image)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupViews() {
        let question = GameSession.shared.currentQuestion
        
        addUILabel(text: question.questionText)
        
        if let colorCard = question.card as? ColorCard {
            let imageName = colorCard.imageName
            addUIImageView(named: imageName)
            return
        }
        
        if let countCard = question.card as? CountCard {
            let imageName = countCard.imageName
            addUIImageView(named: imageName)
            return
        }
        
    }

}
