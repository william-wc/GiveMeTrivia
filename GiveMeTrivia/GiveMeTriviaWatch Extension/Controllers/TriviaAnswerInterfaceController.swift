//
//  TriviaQuestionController.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import WatchKit

class TriviaAnswerInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var textAnswer   : WKInterfaceLabel!
    @IBOutlet weak var buttonNext   : WKInterfaceButton!
    @IBOutlet weak var buttonAdd    : WKInterfaceButton!
    
    var clue: JSClue? {
        didSet {
            updateUI()
        }
    }
    var triviaDelegate: TriviaControllerDelegate?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let context = context as? TriviaControllerDelegate {
            self.triviaDelegate = context
            self.clue = context.getClue()
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}

extension TriviaAnswerInterfaceController {
    
    @IBAction func didSelectNext(sender: WKInterfaceButton) {
        triviaDelegate?.controllerRequestedNext()
    }
    
    @IBAction func didSelectAdd(sender: WKInterfaceButton) {
        triviaDelegate?.controllerMarkedCategory()
        updateButton()
    }
    
}

private extension TriviaAnswerInterfaceController {
    
    func updateUI() {
        if let clue = clue {
            textAnswer.setText(clue.answer)
            updateButton()
        } else {
            
        }
    }
    
    func updateButton() {
        if let clue = clue {
            let isActive = triviaDelegate?.isUserCategoryActive(clue.idCategory) ?? false
            buttonAdd.setTitle(isActive ? "Remove Category" : "Add Category")
        } else {
            
        }
    }
    
}