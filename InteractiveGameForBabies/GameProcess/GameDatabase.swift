//
//  GameDatabase.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class GameDatabase {
    
    static let shared = GameDatabase()
    
    private init() {
    }
    
    var animalCards: [AnimalCard] = []
    
    var animalQuestions: [AnimalQuestion] = []
    
    var colorCards: [ColorCard] = []
    
    var colorQuestions: [ColorQuestion] = [
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .green),
                      questionText: "Нажми на все предметы зеленого цвета"),
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .yellow),
                      questionText: "Нажми на все предметы желтого цвета"),
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .red),
                      questionText: "Нажми на все предметы красного цвета"),
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .blue),
                      questionText: "Нажми на все предметы синего цвета"),
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .grey),
                      questionText: "Нажми на все предметы серого цвета"),
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .black),
                      questionText: "Нажми на все предметы черного цвета"),
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .orange),
                      questionText: "Нажми на все предметы оранжевого цвета"),
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .violet),
                      questionText: "Нажми на все предметы фиолетового цвета"),
        ColorQuestion(colorCard: ColorCard(imageName: "", color: .pink),
                      questionText: "Нажми на все предметы розового цвета")
    ]
    
    var countCards: [CountCard] = []
    
    var countQuestions: [CountQuestion] = [
        CountQuestion(countCard: CountCard(imageName: "", count: .one),
                      questionText: "Нажми на все картинки, где предмет один"),
        CountQuestion(countCard: CountCard(imageName: "", count: .many),
                      questionText: "Нажми на все картинки, где предметов много")
    ]
    
    var figureCards: [FigureCard] = []
    
    var figureQuestions: [FigureQuestion] = []
    
    
}
