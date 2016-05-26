//
//  JServiceParser.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import Foundation

typealias Payload = [String: AnyObject]

class JServiceParser {
    
    class func parseClue(json: Payload) -> JSClue? {
        let json = nestedValue(json, key: "clue")
        guard let id        = json["id"] as? Int
            , idCategory    = json["category_id"] as? Int
            , question      = json["question"] as? String
            , answer        = json["answer"] as? String
            , value         = json["value"] as? Int else {
            print("Clue didnt parse properly")
            return nil
        }
        
        let clue = JSClue(id: id, idCategory: idCategory, question: question, answer: answer, value: value)
        let category = parseCategory(json)
        clue.category = category
        return clue
    }
    
    class func parseClueList(json: [Payload]) -> [JSClue] {
        return json.flatMap({ parseClue($0) })
    }
    
    class func parseCategory(json: Payload) -> JSCategory? {
        let json = nestedValue(json, key: "category")
        guard let id        = json["id"] as? Int
            , title         = json["title"] as? String
            , count         = json["clues_count"] as? Int else {
            print("Category didnt parse properly")
            return nil
        }
        return JSCategory(id: id, title: title, cluesCount: count)
    }
    
    class func parseCategoryList(json: [Payload]) -> [JSCategory] {
        return json.flatMap({ parseCategory($0) })
    }
    
    class func nestedValue(json: Payload, key:String) -> Payload {
        if let nest = json[key] as? Payload {
            return nest
        }
        return json
    }
}