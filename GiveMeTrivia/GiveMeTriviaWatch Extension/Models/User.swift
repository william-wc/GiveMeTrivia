//
//  User.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import Foundation

class User {
    
    //categories added by the user
    var categories: [UserCategory]
    
    private let defaults: NSUserDefaults?
    
    init() {
        defaults = NSUserDefaults(user: "GiveMeTrivia")
        if let cat = defaults?.arrayForKey("categories") as? [[String: AnyObject]] {
            print("categories found: \(cat)")
            categories = cat.flatMap({ UserCategory(dict: $0) })
        } else {
            print("categories empty")
            categories = []
        }
    }
    
    func hasCategory(id: Int) -> Bool {
        return categories.contains({ $0.id == id })
    }
    
    func addCategory(category: JSCategory) {
        if !categories.contains({ $0.id == category.id }) {
            let ucat = UserCategory(category: category)
            categories.append(ucat)
            save()
        }
    }
    
    func removeCategory(id: Int) {
        if let index = categories.indexOf({ $0.id == id}) {
            categories.removeAtIndex(index)
            save()
        }
    }
    
    func isCategoryActve(id: Int) -> Bool {
        return categories.contains({ $0.id == id && $0.isActive })
    }
    
    func setCategoryActive(id: Int, active: Bool) {
        if let index = categories.indexOf({ $0.id == id}) {
            categories[index].isActive = active
            save()
        }
    }
    
    var activeCategories: [Int] {
        return categories.filter({ $0.isActive }).map({ $0.id })
    }
    
    func save() {
        defaults?.setValue(categories.map({$0.toDict}), forKey: "categories")
    }
}

class UserCategory : CustomStringConvertible {
    
    let id: Int
    let name: String
    let clueCount: Int
    var isActive: Bool
    
    init(id: Int, name: String, count: Int, isActive: Bool) {
        self.id = id
        self.name = name
        self.clueCount = count
        self.isActive = isActive
    }
    
    init?(dict: [String: AnyObject]) {
        guard let id = dict["id"] as? Int
            , name = dict["name"] as? String
            , clueCount = dict["clueCount"] as? Int
            , isActive = dict["isActive"] as? Bool else {
            return nil
        }
        self.id = id
        self.name = name
        self.clueCount = clueCount
        self.isActive = isActive
    }
    
    init(category: JSCategory) {
        self.id = category.id
        self.name = category.title
        self.clueCount = category.cluesCount
        self.isActive = true
    }
    
    var description: String {
        return "(\(id)-\(name)-\(isActive))"
    }
    
    var toTuple: (Int, String, Int, Bool) {
        return (id, name, clueCount, isActive)
    }
    
    var toDict: [String: AnyObject] {
        return ["id": id, "name": name, "clueCount": clueCount, "isActive": isActive]
    }
}