//
//  SpeakAnimalGameViewController.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import UIKit

class SpeakAnimalGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: - SetUpUI
    
    private func setUpUI(){
        
        view.addSubview(questionLabel)
        view.addSubview(soundButton)
        view.addSubview(stackView)
        
        view.backgroundColor = .white
        
        self.title = "Как говорят животные"
        
        let questionLabelTopConstraint = NSLayoutConstraint(item: questionLabel,
                                                            attribute: .top,
                                                            relatedBy: .equal,
                                                            toItem: view,
                                                            attribute: .top,
                                                            multiplier: 0.7,
                                                            constant: 100)
        
        
        NSLayoutConstraint.activate([
            questionLabelTopConstraint,
            questionLabel
                .leadingAnchor
                .constraint(equalTo: view.leadingAnchor,
                            constant: 16),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: view.trailingAnchor,
                            constant: -132),
            questionLabel
                .heightAnchor
                .constraint(equalToConstant: 100),
            soundButton
                .topAnchor
                .constraint(equalTo: questionLabel.topAnchor,
                            constant: 0),
            soundButton
                .leadingAnchor
                .constraint(equalTo: questionLabel.trailingAnchor,
                            constant: 16),
            soundButton
                .heightAnchor
                .constraint(equalToConstant: 100),
            soundButton
                .widthAnchor
                .constraint(equalToConstant: 100),
            stackView
                .topAnchor
                .constraint(equalTo: questionLabel.bottomAnchor,
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
    
    //MARK: - Views
    
    let questionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Какое животное так говорит?"
        return label
    }()
    
    
    lazy var soundButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(soundButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func soundButtonTapped() {
        
        print("Нажали кнопку звука")
        //по нажатию проигрывание звука животного (при создании экрана в GameSession из массива GameDataBase рандомной функцией из Рандомайзера выбирается одно значение)
        
    }
    
    @objc func animalCardButtonTapped() {
        
        print("Нажали карточку животного")
        //по нажатию запуск функции проверка правильный ли это ответ из какого то класса GameProcess
    }
    
    let stackView: UIStackView = {

             let animalCardImages = [
                 UIImage(named: "animal1"),
                 UIImage(named: "animal2"),
                 UIImage(named: "animal3"),
                 UIImage(named: "animal4"),
                 UIImage(named: "animal5"),
                 UIImage(named: "animal6")
             ]

             let stackView = UIStackView()
             stackView.axis = .vertical
             stackView.alignment = .fill
             stackView.distribution = .fillEqually
             stackView.spacing = 5
             stackView.translatesAutoresizingMaskIntoConstraints = false

             let rows = 3
             let columns = 2

             for row in 0 ..< rows {
                 let stackViewH = UIStackView()
                 stackViewH.axis = .horizontal
                 stackViewH.alignment = .fill
                 stackViewH.distribution = .fillEqually
                 stackViewH.spacing = 5

                 for col in 0 ..< columns {
                     let index = row * columns + col
                     
                     let animalCardButton: AnimalCardButton = {
                         let button = AnimalCardButton()
                         button.image = animalCardImages[index]
                         button.addTarget(self, action: #selector(animalCardButtonTapped), for: .touchUpInside)
                         
                         //Xcode предлагает self изменить на SpeakAnimalGameViewController.self, но тогда при нажатии вылетает ошибка, не надо так менять
                         
                         button.translatesAutoresizingMaskIntoConstraints = false
                         return button
                     }()
                     
                     stackViewH.addArrangedSubview(animalCardButton)
                 }

                 stackView.addArrangedSubview(stackViewH)
             }

             return stackView
         }()

}
