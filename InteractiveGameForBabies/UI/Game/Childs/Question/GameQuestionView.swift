//
//  GameQuestionView.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import SwiftUI
import AVFoundation

class GameQuestionView: UIView {
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(QuestionTextOnlyCell.self, forCellReuseIdentifier: QuestionTextOnlyCell.reuseId)
        tableView.register(QuestionSoundCell.self, forCellReuseIdentifier: QuestionSoundCell.reuseId)
        tableView.register(QuestionImageCell.self, forCellReuseIdentifier: QuestionImageCell.reuseId)
        
        return tableView
    }()
    
    private var mediaType: MediaType  = .none
    
    private var player: AVPlayer = {
        return AVPlayer()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMediaView(type: MediaType) {
        mediaType = type
        tableView.reloadData()
    }
    
    private func setupView() {
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: 4),
            tableView
                .bottomAnchor
                .constraint(equalTo: bottomAnchor,
                            constant: -4),
            tableView
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: -4),
            tableView
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: 4),
        ])
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(playerEndPlay),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: nil)
    }
    
    @objc func playerEndPlay() {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? QuestionSoundCell {
            cell.resetState()
        }
        
        print("ended")
    }
}

extension GameQuestionView : UITableViewDelegate {
    
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionSoundCell.reuseId, for: indexPath) as? QuestionSoundCell {
                cell.configure(with: "Кто так говорит?")
                cell.delegate = self
                return cell
            }
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionImageCell.reuseId, for: indexPath) as? QuestionImageCell {
                cell.configure(with: "Нажми на все карточки, где ты видишь только один предмет", image: "colors")
                return cell
            }
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTextOnlyCell.reuseId, for: indexPath) as? QuestionTextOnlyCell {
                cell.configure(with: "Нажми на все карточки, где ты видишь синий предмет")
                return cell
            }
        case .none:
            return UITableViewCell()
        }
        
        fatalError("Cell for item at \(indexPath) has not been implemented")
    }
}

extension GameQuestionView : QuestionSoundCellDelegate {
    
    func didTapPlayButtonInCell() {
        guard let url = Bundle
                .main
                .url(forResource: "wolf",
                     withExtension: "mp3")
        else { return }
        
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        
        switch player.timeControlStatus {
        case .playing:
            player.pause()
        case .paused:
            player.play()
        default:
            return
        }
    }
}

struct GameQuestionView_Preview: PreviewProvider {
    static var previews: some View {
        let view = GameQuestionView()
        return UIPreviewView(view)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 375, height: 200))
    }
}
