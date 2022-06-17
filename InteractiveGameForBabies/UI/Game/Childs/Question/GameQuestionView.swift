//
//  GameQuestionView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI
import AVKit

class GameQuestionView: UIView {
    
    private(set) var mediaView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.secondarySystemFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray2.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private(set) var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
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
        addSubview(mediaView)
                
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
                .constraint(equalTo: mediaView.leadingAnchor,
                            constant: 16),
            questionLabel
                .centerYAnchor
                .constraint(equalTo: mediaView.centerYAnchor),

            mediaView
                .heightAnchor
                .constraint(equalToConstant: 64),
            mediaView
                .widthAnchor
                .constraint(equalToConstant: 64),
            mediaView
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: -16),
            mediaView
                .bottomAnchor
                .constraint(lessThanOrEqualTo: bottomAnchor,
                            constant: 16),
            mediaView
                .topAnchor
                .constraint(equalTo: topAnchor, constant: 16),
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        mediaView.layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    func setupMedia(type: MediaType) {

    }
    
    @objc private func handleMediaViewTap(_ sender: UIControl) {

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
