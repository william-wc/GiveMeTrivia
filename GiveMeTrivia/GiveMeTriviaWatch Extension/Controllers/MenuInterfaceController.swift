//
//  MenuController.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import WatchKit

class MenuInterfaceController: WKInterfaceController {
    
    var user: User!
    private var trivia: TriviaController?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        user = User()
    }
    
    override func willActivate() {
        super.willActivate()
        trivia?.stop()
        trivia = nil
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}

extension MenuInterfaceController {
    
    @IBAction func didSelectTrivia(sender: WKInterfaceButton) {
        trivia = TriviaController(type: .Random, presenter: self, user: user)
        trivia?.start()
    }
    
    @IBAction func didSelectCategories(sender: WKInterfaceButton) {
        trivia = TriviaController(type: .Categories, presenter: self, user: user)
        trivia?.start()
    }
    
    @IBAction func didSelectSettings(sender: WKInterfaceButton) {
        presentControllerWithName(.Settings, context: user)
    }
}
