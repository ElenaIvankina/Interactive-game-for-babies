//
//  GameItemView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 14.06.2022.
//

import UIKit
import SwiftUI

class GameItemView: UIView {
    
    // MARK: - Subviews
    private lazy var startGameButton: StartGameButton = {
        let button = StartGameButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bgColor = UIColor.rgba(1.0,
                                      0.533,
                                      0.153,
                                      alpha: 1.0)
        button.borderColor = UIColor.rgba(0.741,
                                          0.031,
                                          0.106,
                                          alpha: 1.0)
        button.layer.borderWidth = 2
        return button
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        return label
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
    
    func configure(name: String, image: UIImage?) {
        self.nameLabel.text = name
        self.startGameButton.image = image
    }
    
    // MARK: - Private methods
    private func setupView() {
        self.addSubview(startGameButton)
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            startGameButton
                .heightAnchor
                .constraint(equalToConstant: 100),
            startGameButton
                .widthAnchor
                .constraint(equalToConstant: 100),
            startGameButton
                .centerXAnchor
                .constraint(equalTo: self.centerXAnchor),
            startGameButton
                .topAnchor
                .constraint(equalTo: self.topAnchor,
                            constant: 10),
            startGameButton
                .bottomAnchor
                .constraint(equalTo: self.nameLabel.topAnchor,
                            constant: -10),
            
            nameLabel
                .leadingAnchor
                .constraint(equalTo: self.leadingAnchor,
                            constant: 15),
            nameLabel
                .trailingAnchor
                .constraint(equalTo: self.trailingAnchor,
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
