//
//  QuestionTableCell.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import WatchKit

class SettingsCategoryCell: NSObject {

    @IBOutlet weak var switchCategory: WKInterfaceSwitch!
    
    var category: UserCategory!
    var delegate: SettingsSwitchDelegate?
    
    @IBAction func didSwitch(switcher: WKInterfaceSwitch) {
        delegate?.didSwitch(category)
    }
}
