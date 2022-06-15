//
//  AnimalCardButton.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 15.06.2022.
//

import UIKit

class AnimalCardButton: UIButton {

     var image: UIImage? = UIImage(named: "animal1") {
         didSet {
             self.setImage(self.image, for: .normal)
         }
     }
    
    //Здесь нужно устанавливать UIImage?, мне кажется можно убрать

     override init(frame: CGRect) {
         super.init(frame: frame)
         self.setupButton()
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         self.setupButton()
     }

     private func setupButton() {
         self.layer.cornerRadius = 20.0
         self.layer.borderWidth = 2.0
     }
 }
