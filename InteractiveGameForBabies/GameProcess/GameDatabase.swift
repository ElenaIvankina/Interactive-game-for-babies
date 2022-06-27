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
    
    var animalCards: [AnimalCard] = [
        AnimalCard(imageName: "animal1", animal: .camel, sound: ""),
        AnimalCard(imageName: "animal2", animal: .mouse, sound: ""),
        AnimalCard(imageName: "animal3", animal: .snake, sound: ""),
        AnimalCard(imageName: "animal4", animal: .woodpecker, sound: ""),
        AnimalCard(imageName: "animal5", animal: .cock, sound: ""),
        AnimalCard(imageName: "animal6", animal: .cat, sound: ""),
        AnimalCard(imageName: "animal7", animal: .elephant, sound: ""),
        AnimalCard(imageName: "animal9", animal: .monkey, sound: ""),
        AnimalCard(imageName: "animal10", animal: .goat, sound: ""),
        AnimalCard(imageName: "animal11", animal: .mouse, sound: ""),
        AnimalCard(imageName: "animal12", animal: .dog, sound: ""),
        AnimalCard(imageName: "animal13", animal: .cuckoo, sound: ""),
        AnimalCard(imageName: "animal14", animal: .hedgehog, sound: ""),
        AnimalCard(imageName: "animal15", animal: .mouse, sound: ""),
        AnimalCard(imageName: "animal16", animal: .frog, sound: ""),
        AnimalCard(imageName: "animal17", animal: .cow, sound: ""),
        AnimalCard(imageName: "animal18", animal: .wolf, sound: ""),
        AnimalCard(imageName: "animal19", animal: .owl, sound: ""),
        AnimalCard(imageName: "animal20", animal: .bear, sound: ""),
        AnimalCard(imageName: "animal21", animal: .parrot, sound: ""),
        AnimalCard(imageName: "animal22", animal: .horse, sound: ""),
        AnimalCard(imageName: "animal23", animal: .donkey, sound: ""),
        AnimalCard(imageName: "animal24", animal: .bear, sound: "")
    ]
    
    var animalQuestions: [AnimalQuestion] = [
        AnimalQuestion(card: AnimalCard(imageName: "animal1", animal: .camel, sound: "camel")),
        AnimalQuestion(card: AnimalCard(imageName: "animal2", animal: .mouse, sound: "mouse")),
        AnimalQuestion(card: AnimalCard(imageName: "animal3", animal: .snake, sound: "snake")),
        AnimalQuestion(card: AnimalCard(imageName: "animal4", animal: .woodpecker, sound: "woodpecker")),
        AnimalQuestion(card: AnimalCard(imageName: "animal5", animal: .cock, sound: "chicken")),
        AnimalQuestion(card: AnimalCard(imageName: "animal6", animal: .cat, sound: "cat")),
        AnimalQuestion(card: AnimalCard(imageName: "animal7", animal: .elephant, sound: "elephant")),
        AnimalQuestion(card: AnimalCard(imageName: "animal9", animal: .monkey, sound: "monkey")),
        AnimalQuestion(card: AnimalCard(imageName: "animal10", animal: .goat, sound: "goat")),
        AnimalQuestion(card: AnimalCard(imageName: "animal11", animal: .mouse, sound: "mouse")),
        AnimalQuestion(card: AnimalCard(imageName: "animal12", animal: .dog, sound: "dog")),
        AnimalQuestion(card: AnimalCard(imageName: "animal13", animal: .cuckoo, sound: "cuckoo")),
        AnimalQuestion(card: AnimalCard(imageName: "animal14", animal: .hedgehog, sound: "hedgehog")),
        AnimalQuestion(card: AnimalCard(imageName: "animal15", animal: .mouse, sound: "rodent")),
        AnimalQuestion(card: AnimalCard(imageName: "animal16", animal: .frog, sound: "frog")),
        AnimalQuestion(card: AnimalCard(imageName: "animal17", animal: .cow, sound: "cow")),
        AnimalQuestion(card: AnimalCard(imageName: "animal18", animal: .wolf, sound: "wolf")),
        AnimalQuestion(card: AnimalCard(imageName: "animal19", animal: .owl, sound: "owl")),
        AnimalQuestion(card: AnimalCard(imageName: "animal20", animal: .bear, sound: "bear")),
        AnimalQuestion(card: AnimalCard(imageName: "animal21", animal: .parrot, sound: "parrot")),
        AnimalQuestion(card: AnimalCard(imageName: "animal22", animal: .horse, sound: "horse")),
        AnimalQuestion(card: AnimalCard(imageName: "animal23", animal: .donkey, sound: "donkey")),
        AnimalQuestion(card: AnimalCard(imageName: "animal24", animal: .bear, sound: "bear"))
    ]
    
    var colorCards: [ColorCard] = [
        ColorCard(imageName: "green1", color: .green),
        ColorCard(imageName: "green2", color: .green),
        ColorCard(imageName: "green3", color: .green),
        ColorCard(imageName: "green4", color: .green),
        ColorCard(imageName: "yellow1", color: .yellow),
        ColorCard(imageName: "yellow2", color: .yellow),
        ColorCard(imageName: "yellow3", color: .yellow),
        ColorCard(imageName: "yellow4", color: .yellow),
        ColorCard(imageName: "red1", color: .red),
        ColorCard(imageName: "red2", color: .red),
        ColorCard(imageName: "red3", color: .red),
        ColorCard(imageName: "red4", color: .red),
        ColorCard(imageName: "blue1", color: .blue),
        ColorCard(imageName: "blue2", color: .blue),
        ColorCard(imageName: "blue3", color: .blue),
        ColorCard(imageName: "blue4", color: .blue),
        ColorCard(imageName: "grey1", color: .grey),
        ColorCard(imageName: "grey2", color: .grey),
        ColorCard(imageName: "grey3", color: .grey),
        ColorCard(imageName: "grey4", color: .grey),
        ColorCard(imageName: "black1", color: .black),
        ColorCard(imageName: "black2", color: .black),
        ColorCard(imageName: "black3", color: .black),
        ColorCard(imageName: "black4", color: .black),
        ColorCard(imageName: "orange1", color: .orange),
        ColorCard(imageName: "orange2", color: .orange),
        ColorCard(imageName: "orange3", color: .orange),
        ColorCard(imageName: "orange4", color: .orange),
        ColorCard(imageName: "violet1", color: .violet),
        ColorCard(imageName: "violet2", color: .violet),
        ColorCard(imageName: "violet3", color: .violet),
        ColorCard(imageName: "violet4", color: .violet),
        ColorCard(imageName: "pink1", color: .pink),
        ColorCard(imageName: "pink2", color: .pink),
        ColorCard(imageName: "pink3", color: .pink),
        ColorCard(imageName: "pink4", color: .pink)
    ]
    
    var colorQuestions: [ColorQuestion] = [
        ColorQuestion(card: ColorCard(imageName: "green0", color: .green),
                      questionText: "Нажми на все предметы зеленого цвета"),
        ColorQuestion(card: ColorCard(imageName: "yellow0", color: .yellow),
                      questionText: "Нажми на все предметы желтого цвета"),
        ColorQuestion(card: ColorCard(imageName: "red0", color: .red),
                      questionText: "Нажми на все предметы красного цвета"),
        ColorQuestion(card: ColorCard(imageName: "blue0", color: .blue),
                      questionText: "Нажми на все предметы синего цвета"),
        ColorQuestion(card: ColorCard(imageName: "grey0", color: .grey),
                      questionText: "Нажми на все предметы серого цвета"),
        ColorQuestion(card: ColorCard(imageName: "black0", color: .black),
                      questionText: "Нажми на все предметы черного цвета"),
        ColorQuestion(card: ColorCard(imageName: "orange0", color: .orange),
                      questionText: "Нажми на все предметы оранжевого цвета"),
        ColorQuestion(card: ColorCard(imageName: "violet0", color: .violet),
                      questionText: "Нажми на все предметы фиолетового цвета"),
        ColorQuestion(card: ColorCard(imageName: "pink0", color: .pink),
                      questionText: "Нажми на все предметы розового цвета")
    ]
    
    var countCards: [CountCard] = [
        CountCard(imageName: "one1", count: .one),
        CountCard(imageName: "one2", count: .one),
        CountCard(imageName: "one3", count: .one),
        CountCard(imageName: "one4", count: .one),
        CountCard(imageName: "one5", count: .one),
        CountCard(imageName: "one6", count: .one),
        CountCard(imageName: "one7", count: .one),
        CountCard(imageName: "one8", count: .one),
        CountCard(imageName: "one9", count: .one),
        CountCard(imageName: "one10", count: .one),
        CountCard(imageName: "one11", count: .one),
        CountCard(imageName: "one12", count: .one),
        CountCard(imageName: "one13", count: .one),
        CountCard(imageName: "one14", count: .one),
        CountCard(imageName: "one15", count: .one),
        CountCard(imageName: "one16", count: .one),
        CountCard(imageName: "one17", count: .one),
        CountCard(imageName: "many1", count: .many),
        CountCard(imageName: "many2", count: .many),
        CountCard(imageName: "many3", count: .many),
        CountCard(imageName: "many4", count: .many),
        CountCard(imageName: "many5", count: .many),
        CountCard(imageName: "many6", count: .many),
        CountCard(imageName: "many7", count: .many),
        CountCard(imageName: "many8", count: .many),
        CountCard(imageName: "many9", count: .many),
        CountCard(imageName: "many10", count: .many),
        CountCard(imageName: "many11", count: .many),
        CountCard(imageName: "many12", count: .many),
        CountCard(imageName: "many13", count: .many),
        CountCard(imageName: "many14", count: .many),
        CountCard(imageName: "many15", count: .many),
        CountCard(imageName: "many16", count: .many),
        CountCard(imageName: "many17", count: .many)
    ]
    
    var countQuestions: [CountQuestion] = [
        CountQuestion(card: CountCard(imageName: "one0", count: .one),
                      questionText: "Нажми на все картинки, где предмет один"),
        CountQuestion(card: CountCard(imageName: "many0", count: .many),
                      questionText: "Нажми на все картинки, где предметов много")
    ]
    
    var figureCards: [FigureCard] = [
        FigureCard(imageName: "circleA", figure: .circle, imageNameFill: "circleAFill"),
        FigureCard(imageName: "diamondA", figure: .diamond, imageNameFill: "diamondAFill"),
        FigureCard(imageName: "eightangleA", figure: .eightangle, imageNameFill: "eightangleAFill"),
        FigureCard(imageName: "fiveangleA", figure: .fiveangle, imageNameFill: "fiveangleAFill"),
        FigureCard(imageName: "heartA", figure: .heart, imageNameFill: "heartAFill"),
        FigureCard(imageName: "nineangleA", figure: .nineangle, imageNameFill: "nineangleAFill"),
        FigureCard(imageName: "ovalA", figure: .oval, imageNameFill: "ovalAFill"),
        FigureCard(imageName: "parallelogramA", figure: .parallelogram, imageNameFill: "parallelogramAFill"),
        FigureCard(imageName: "rectangleA", figure: .rectangle, imageNameFill: "rectangleAFill"),
        FigureCard(imageName: "semicircleA", figure: .semicircle, imageNameFill: "semicircleAFill"),
        FigureCard(imageName: "sevenangleA", figure: .sevenangle, imageNameFill: "sevenangleAFill"),
        FigureCard(imageName: "sixangleA", figure: .sixangle, imageNameFill: "sixangleAFill"),
        FigureCard(imageName: "squareA", figure: .square, imageNameFill: "squareAFill"),
        FigureCard(imageName: "starA", figure: .star, imageNameFill: "starAFill"),
        FigureCard(imageName: "trapezoidA", figure: .trapezoid, imageNameFill: "trapezoidAFill"),
        FigureCard(imageName: "triangleA", figure: .triangle, imageNameFill: "triangleAFill")
    ]
    
    
    
    var figureQuestions: [FigureQuestion] = {
        
        var figureCardsQuestion = [
            FigureCard(imageName: "circleQ", figure: .circle, imageNameFill: ""),
            FigureCard(imageName: "diamondQ", figure: .diamond, imageNameFill: ""),
            FigureCard(imageName: "eightangleQ", figure: .eightangle, imageNameFill: ""),
            FigureCard(imageName: "fiveangleQ", figure: .fiveangle, imageNameFill: ""),
            FigureCard(imageName: "heartQ", figure: .heart, imageNameFill: ""),
            FigureCard(imageName: "nineangleQ", figure: .nineangle, imageNameFill: ""),
            FigureCard(imageName: "ovalQ", figure: .oval, imageNameFill: ""),
            FigureCard(imageName: "parallelogramQ", figure: .parallelogram, imageNameFill: ""),
            FigureCard(imageName: "rectangleQ", figure: .rectangle, imageNameFill: ""),
            FigureCard(imageName: "semicircleQ", figure: .semicircle, imageNameFill: ""),
            FigureCard(imageName: "sevenangleQ", figure: .sevenangle, imageNameFill: ""),
            FigureCard(imageName: "sixangleQ", figure: .sixangle, imageNameFill: ""),
            FigureCard(imageName: "squareQ", figure: .square, imageNameFill: ""),
            FigureCard(imageName: "starQ", figure: .star, imageNameFill: ""),
            FigureCard(imageName: "trapezoidQ", figure: .trapezoid, imageNameFill: ""),
            FigureCard(imageName: "triangleQ", figure: .triangle, imageNameFill: "")
        ]
        
        let lenghtArr = 4
        var arr: [FigureQuestion] = []
        
        for i in 0...30 {
            let arrFigureCards: [FigureCard] = figureCardsQuestion.shuffled().suffix(lenghtArr)
            let figureQuestion = FigureQuestion(cardsFigure: arrFigureCards)
            arr.append(figureQuestion)
        }
        return arr
    }()
}
