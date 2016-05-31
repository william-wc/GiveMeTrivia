//
//  Extensions.swift
//  GiveMeTrivia
//
//  Created by William Cho on 5/26/16.
//  Copyright © 2016 wc. All rights reserved.
//

import WatchKit

extension Array {
    
    func random() -> Element? {
        if self.isEmpty {
            return nil
        } else {
            return self[Int(arc4random_uniform(UInt32(self.count)))]
        }
    }
}

extension WKInterfaceTable {
    
    func setRowTypes(rowTypes: [TableRowType]) {
        self.setRowTypes(rowTypes.map({$0.rawValue}))
    }
    
    func setNumberOfRows(numberOfRows: Int, withRowType rowType: TableRowType) {
        self.setNumberOfRows(numberOfRows, withRowType: rowType.rawValue)
    }
    
    func insertRowsAtIndexes(rows: NSIndexSet, withRowType rowType: TableRowType) {
        self.insertRowsAtIndexes(rows, withRowType: rowType.rawValue)
    }
}

extension WKInterfaceController {
    
    func pushControllerWithName(name: ControllerName, context: AnyObject?) {
        self.pushControllerWithName(name.rawValue, context: context)
    }
    
    func presentControllerWithName(name: ControllerName, context: AnyObject?) {
        self.presentControllerWithName(name.rawValue, context: context)
    }
    
    func presentControllerWithNames(names: [ControllerName], contexts: [AnyObject]?) {
        self.presentControllerWithNames(names.map({$0.rawValue}), contexts: contexts)
    }
    
}