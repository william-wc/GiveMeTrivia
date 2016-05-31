//
//  TriviaController.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import WatchKit

protocol TriviaControllerDelegate {
    
    func controllerRequestedNext()
    func controllerMarkedCategory()
    func isUserCategoryActive(id: Int) -> Bool
    func getClue() -> JSClue?
    func getCategory() -> JSCategory?
    
}

class TriviaController {
    
    let presenter: WKInterfaceController
    let type: TriviaType
    let user: User
    
    private(set) var clue: JSClue?
    private(set) var category: JSCategory?
    
    private var controllers: [WKInterfaceController]
    private var hasCanceled: Bool
    
    init(type: TriviaType, presenter: WKInterfaceController, user: User) {
        self.type = type
        self.presenter = presenter
        self.user = user
        self.hasCanceled = false
        controllers = []
    }
    
    func start() {
        hasCanceled = false
        
        switch type {
        case .Random        : makeRandomRequest()
        case .Categories    : makeCategoryRequest()
        }
        
        showAlert()
    }
    
    func stop() {
        removeControllers()
    }
    
}

extension TriviaController: TriviaControllerDelegate {
    
    func controllerRequestedNext() {
        stop()
        start()
    }
    
    func controllerMarkedCategory() {
        if let category = category {
            if user.hasCategory(category.id) {
                user.setCategoryActive(category.id, active: !user.isCategoryActve(category.id))
            } else {
                user.addCategory(category)
            }
        }
    }
    
    func isUserCategoryActive(id: Int) -> Bool {
        return user.isCategoryActve(id)
    }
    
    func getClue() -> JSClue? {
        return clue
    }
    
    func getCategory() -> JSCategory? {
        return category
    }
    
}

private extension TriviaController {
    
    func showControllers() {
        presenter.presentControllerWithNames([.Question, .Answer], contexts: [self, self])
    }
    
    func removeControllers() {
        presenter.dismissController()
    }
    
    func showAlert() {
        let action = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.Cancel) {
            self.hasCanceled = true
        }
        presenter.presentAlertControllerWithTitle("Loading...", message: nil, preferredStyle: WKAlertControllerStyle.Alert, actions: [action])
    }
    
    func makeRandomRequest() {
        JServiceConnector.getRandomClues(1, callback: { (clues) in
            guard !self.hasCanceled else {
                print("cancelled random")
                return
            }
            if let clue = clues.first, category = clue.category {
                self.clue = clue
                self.category = category
                self.presenter.dismissController()
                self.showControllers()
            } else {
                print("[\(self)], Error requesting random clue")
            }
        })
    }
    
    func makeCategoryRequest() {
        let ids = user.activeCategories
        if let id = ids.random() {
            JServiceConnector.getCategoryClues(id, callback: { (category, clues) in
                guard !self.hasCanceled else {
                    print("cancelled category")
                    return
                }
                if let clue = clues.random() {
                    self.category = category
                    self.clue = clue
                    self.presenter.dismissController()
                    self.showControllers()
                } else {
                    print("\(self), Error category requested is empty")
                }
            })
        } else {
            print("\(self), ids are empty, making random request")
            makeRandomRequest()
        }
    }
}