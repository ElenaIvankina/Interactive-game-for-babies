//
//  CountGameViewController.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import UIKit

class CountGameViewController: UIViewController {
    private var headerLabel: UILabel!
    private var questionLabel: UILabel!
    private var questionImage: UIImageView!
    private var questionStackView: UIStackView!
    private var countQuestion: CountQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        headerLabel = setupHeaderLabel()
        view.addSubview(headerLabel)
        
        questionLabel = setupQuestionLabel(countQuestion: self.countQuestion)
        view.addSubview(questionLabel)

        questionImage = setupQuestionImage(countQuestion: self.countQuestion)
        view.addSubview(questionImage)
        
        questionStackView = setupQuestionStackView()
        view.addSubview(questionStackView)
        
        NSLayoutConstraint.activate([
            
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -16),
            headerLabel.heightAnchor.constraint(equalToConstant: 20),
            
            questionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -96),
            
            questionImage.topAnchor.constraint(equalTo: questionLabel.topAnchor),
            questionImage.leftAnchor.constraint(equalTo: questionLabel.rightAnchor),
            questionImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            questionImage.heightAnchor.constraint(equalToConstant: 80),
            
            questionStackView.topAnchor.constraint(equalTo: questionImage.bottomAnchor, constant: 120),
            questionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            questionStackView.heightAnchor.constraint(equalToConstant: 320)
//            questionStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            
        ])
    }
    
    // MARK: - setup views
    
    private func setupHeaderLabel() -> UILabel {
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Вопрос 1 из 10" //номер текущего вопроса брать из текущей сессии (если оно вообще тут надо)
        headerLabel.font = .boldSystemFont(ofSize: 16)
        headerLabel.textAlignment = .center
        return headerLabel
    }
    
    private func setupQuestionLabel(countQuestion: CountQuestion?) -> UILabel {
        let headLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 16))
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        headLabel.text = countQuestion?.questionText ?? "Нажми на все картинки на экране где ты видишь только один предмет"
        headLabel.font = .systemFont(ofSize: 16)
        headLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        headLabel.numberOfLines = 0
        return headLabel
    }
    
    private func setupQuestionImage(countQuestion: CountQuestion?) -> UIImageView {
        var questionImage: UIImage?
        if let countQuestionImageName = countQuestion?.card.imageName {
            questionImage =  UIImage(named: countQuestionImageName)
        } else {
            questionImage =  UIImage(systemName: "tortoise.fill")
        }
        
        let questionImageView = UIImageView()
        questionImageView.translatesAutoresizingMaskIntoConstraints = false
        questionImageView.image = questionImage
        let borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        questionImageView.layer.borderColor = borderColor
        questionImageView.layer.borderWidth = 2
        return questionImageView
    }
    
    private func setupQuestionStackView() -> UIStackView { //добавить параметр с ответами, что бы дальше сконфигурировать кнопки с картинками
        let stackView = setupStackView(axis: .vertical)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
        var tag = 0
        for _ in 0...1 {
            let stackViewH = setupStackView(axis: .horizontal)
            for _ in 0...2 {
                let answerButton = setupAnswerButton(tag: tag, imageName: nil) //тут вместо imageName надо прокинуть параметр, где будет картинка с ответом
                stackViewH.addArrangedSubview(answerButton)
                tag += 1
            }
            stackView.addArrangedSubview(stackViewH)
        }
        
        return stackView
    }
    
    private func setupStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }
    
    private func setupAnswerButton(tag: Int, imageName: String?) -> UIButton {
        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = tag
        var image: UIImage?
        if let imageName = imageName {
            image = UIImage(named: imageName)
        } else {
            image = getHardcoreImage(tag: tag)
        }
        button.setImage(image, for: .normal)
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        button.layer.borderWidth = 2
        return button
    }
    
    private func getHardcoreImage(tag: Int) -> UIImage? {
        var name = ""
        switch tag {
        case 0:
            name = "person.fill"
        case 1:
            name = "person"
        case 2:
            name = "person.2"
        case 3:
            name = "person.2.fill"
        case 4:
            name = "person.3"
        case 5:
            name = "person.3.fill"
        default:
            name = "trash.fill"
        }
        return UIImage(systemName: name)
    
    }
    
    //Наверху экрана UILabel с вопросом, чуть правее картинка, под ними 6 одинаковых элементов, которые реализуют возможность нажатия и проверки данных (кнопка, просто UI Control и тд) (6 элементов возможно будет удобно обернуть в stackView), в readme есть картинка


}
