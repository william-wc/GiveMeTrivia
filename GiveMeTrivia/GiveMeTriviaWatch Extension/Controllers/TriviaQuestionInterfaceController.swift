//
//  TriviaQuestionController.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import WatchKit

class TriviaQuestionInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var textCategory : WKInterfaceLabel!
    @IBOutlet weak var textQuestion : WKInterfaceLabel!
    
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

private extension TriviaQuestionInterfaceController {
    
    func updateUI() {
        if let clue = clue {
            textCategory.setText(clue.category?.title)
            textQuestion.setText(clue.question);
        } else {
            
        }
    }
    
}