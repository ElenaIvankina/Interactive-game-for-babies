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
        
        tableView.register(QuestionTextOnlyCell.self,
                           forCellReuseIdentifier: QuestionTextOnlyCell.reuseId)
        tableView.register(QuestionSoundCell.self,
                           forCellReuseIdentifier: QuestionSoundCell.reuseId)
        tableView.register(QuestionImageCell.self,
                           forCellReuseIdentifier: QuestionImageCell.reuseId)
        
        return tableView
    }()
    
    private var player: AVPlayer = {
        return AVPlayer()
    }()
    
    private var mediaType: MediaType  = .none
//    private var question: QuestionProtocol?
    
    private enum Constants {
        static let inset: CGFloat = 4
    }
    
    var viewHeight: CGFloat {
        var height = 2 * Constants.inset
        
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
            height += cell.frame.height
        } else {
            height += tableView.contentSize.height
        }
        
        return height
    }
    
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
    
//    func setQuestion(question: QuestionProtocol) {
//        self.question = question
//        tableView.reloadData()
//    }
    
    private func setupView() {
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: Constants.inset),
            tableView
                .bottomAnchor
                .constraint(equalTo: bottomAnchor,
                            constant: -Constants.inset),
            tableView
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: -Constants.inset),
            tableView
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: Constants.inset)
        ])
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(playerEndPlay),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: nil)
    }
    
    @objc private func playerEndPlay() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? QuestionSoundCell
        else { return }
        
        cell.resetState()
    }
}

extension GameQuestionView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

    }
}

extension GameQuestionView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mediaType {
        case .none:
            return 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch mediaType {
        case .sound:
            if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionSoundCell.reuseId, for: indexPath) as? QuestionSoundCell {
                cell.configure()
                cell.delegate = self
                return cell
            }
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionImageCell.reuseId, for: indexPath) as? QuestionImageCell {
                cell.configure()
                return cell
            }
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTextOnlyCell.reuseId, for: indexPath) as? QuestionTextOnlyCell {
                cell.configure()
                return cell
            }
        case .none:
            return UITableViewCell()
        }
        
        fatalError("Cell for item at \(indexPath) has not been implemented")
    }
}

extension GameQuestionView: QuestionSoundCellDelegate {
    
    func didTapPlayButtonInCell(isPlaying: Bool) {
        if isPlaying {
            player.replaceCurrentItem(with: nil)
        } else {
            guard let animalCard = GameSession.shared.currentQuestion.card as? AnimalCard,
                  let url = Bundle
                    .main
                    .url(forResource: animalCard.sound,
                         withExtension: "mp3")
            else { return }
            
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
            
            if player.timeControlStatus != .playing {
                player.play()
            }
        }
        
    }
}
