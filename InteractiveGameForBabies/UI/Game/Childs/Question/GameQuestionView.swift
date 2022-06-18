//
//  GameQuestionView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI
import AVKit

class GameQuestionView: UIView {
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        
        tableView.register(TextOnlyCell.self, forCellReuseIdentifier: TextOnlyCell.reuseId)
        tableView.register(SoundCell.self, forCellReuseIdentifier: SoundCell.reuseId)
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseId)
        
        return tableView
    }()
    
    private var mediaType: MediaType  = .none
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupView() {
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ])
    }
    
    func setMediaView(type: MediaType) {
        mediaType = type
        tableView.reloadData()
    }
}

extension GameQuestionView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GameQuestionView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(mediaType) {
        case .none:
            return 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch(mediaType) {
        case .sound:
            if let soundCell = tableView.dequeueReusableCell(withIdentifier: SoundCell.reuseId, for: indexPath) as? SoundCell {
                soundCell.configure(with: "meow")
                return soundCell
            } else {
                return UITableViewCell()
            }
        case .image:
            if let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseId, for: indexPath) as? ImageCell {
                imageCell.configure(with: "123", image: "colors")
                return imageCell
            } else {
                return UITableViewCell()
            }
        case .text:
            if let textCell = tableView.dequeueReusableCell(withIdentifier: TextOnlyCell.reuseId, for: indexPath) as? TextOnlyCell {
                textCell.configure(with: "123")
                return textCell
            } else {
                return UITableViewCell()
            }
        case .none:
            return UITableViewCell()
        }
    }
}

struct GameQuestionView_Preview: PreviewProvider {
    static var previews: some View {
        let view = GameQuestionView()
        view.tableView.reloadData()
        return UIPreviewView(view)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
