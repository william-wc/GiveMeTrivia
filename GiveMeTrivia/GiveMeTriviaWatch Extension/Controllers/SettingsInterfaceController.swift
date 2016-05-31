//
//  SettingsInterfaceController.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import WatchKit

protocol SettingsSwitchDelegate {
    func didSwitch(category: UserCategory)
}

class SettingsInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    private(set) var user: User! {
        didSet {
            updateTable()
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let user = context as? User {
            self.user = user
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        user.save()
    }
    
}

extension SettingsInterfaceController: SettingsSwitchDelegate {
    func didSwitch(category: UserCategory) {
        category.isActive = !category.isActive
    }
}

private extension SettingsInterfaceController {
    
    func updateTable() {
        table.setNumberOfRows(user.categories.count, withRowType: TableRowType.Category)
        for i in 0..<user.categories.count {
            let category = user.categories[i]
            if let cell = table.rowControllerAtIndex(i) as? SettingsCategoryCell {
                cell.switchCategory.setTitle(category.name)
                cell.switchCategory.setOn(category.isActive)
                cell.category = category
                cell.delegate = self
            }
        }
    }
    
}
