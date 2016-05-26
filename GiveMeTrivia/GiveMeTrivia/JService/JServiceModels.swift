//
//  JServiceModels.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import Foundation

protocol JServiceModel {
    
}

class JSClue: JServiceModel {
    
    let id          : Int
    let idCategory  : Int
    let question    : String
    let answer      : String
    let value       : Int
    
    var category    : JSCategory?
    
    init(id: Int, idCategory: Int, question: String, answer: String, value: Int) {
        self.id         = id
        self.idCategory = idCategory
        self.question   = question
        self.answer     = answer
        self.value      = value
    }
    
}

class JSCategory: JServiceModel {
    
    let id          : Int
    let title       : String
    let cluesCount  : Int
    
    init(id: Int, title: String, cluesCount: Int) {
        self.id         = id
        self.title      = title
        self.cluesCount = cluesCount
    }
}

