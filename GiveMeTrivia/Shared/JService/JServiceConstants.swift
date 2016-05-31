//
//  JServiceConstants.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import Foundation

enum JServiceGet {
    case Clues(category: Int?, offset: Int?)
    , Category(id: Int)
    , Categories(count: Int, offset: Int)
    , Random(count: Int)
}