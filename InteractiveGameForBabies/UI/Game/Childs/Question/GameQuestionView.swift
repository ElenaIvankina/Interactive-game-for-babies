//
//  GameQuestionView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI

class GameQuestionView: UIView {
    
    var iconImageView: UIView = {
        /*let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.secondarySystemFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray2.cgColor*/
        return UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }()
    
    private(set) var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupView() {
        addSubview(questionLabel)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            questionLabel
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: 16),
            questionLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: 16),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: iconImageView.trailingAnchor,
                            constant: -16),
            questionLabel
                .centerYAnchor
                .constraint(equalTo: iconImageView.centerYAnchor),

            iconImageView
                .heightAnchor
                .constraint(equalToConstant: 64),
            iconImageView
                .widthAnchor
                .constraint(equalToConstant: 64),
            iconImageView
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: -16),
            iconImageView
                .bottomAnchor
                .constraint(lessThanOrEqualTo: bottomAnchor,
                            constant: 16),
            iconImageView
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 16),
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        iconImageView.layer.borderColor = UIColor.systemGray2.cgColor
    }
}

struct GameQuestionView_Preview: PreviewProvider {
    static var previews: some View {
        let view = GameQuestionView()
        view.questionLabel.text = "ВКонтакте. Ваша социальная сеть"
        return UIPreviewView(view)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
