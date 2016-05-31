//
//  JServiceAPI.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import Foundation

class JServiceAPI {
    
    private var option: JServiceGet
    
    init(option: JServiceGet) {
        self.option = option
    }
    
    func set(option option: JServiceGet) -> JServiceAPI {
        self.option = option
        return self
    }
    
    func get() -> JServiceGet {
        return option
    }
    
    func getUri() -> String {
        var uri = "http://jservice.io/api"
        let parameters: [(String, AnyObject?)]
        switch option {
        case .Clues(let category, let offset)   :
            uri += "/clues"
            parameters = [("category", category), ("offset", offset)]
        case .Category(let id):
            uri += "/category"
            parameters = [("id", id)]
        case .Categories(let count, let offset):
            uri += "/categories"
            parameters = [("count", count), ("offset", offset)]
        case .Random(let count):
            uri += "/random"
            parameters = [("count", count)]
        }
        
        if !parameters.isEmpty {
            uri += "?" + parameters.flatMap({
                if let v = $0.1 {
                    return "\($0.0)=\(v)"
                }
                return nil
            }).joinWithSeparator("&")
        }
        return uri
    }
    
}
