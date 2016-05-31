//
//  Constants.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import Foundation

enum ControllerName: String {
    case Menu       = "Menu"
    , Question      = "TriviaQuestion"
    , Answer        = "TriviaAnswer"
    , Categories    = "Categories"
    , Settings      = "Settings"
}

enum TableRowType: String {
    case Category = "category"
}

enum TriviaType {
    case Random
    , Categories
}