//
//  ParseFieldChecker.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 15.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class ParseFieldChecker: NSObject {
    class func fixNull<T>(object:T?)->T? {
        if (object is NSNull) { return nil }
        return object
    }
    class func fieldDataForJSON<T>(field: T?)->T? {
        if field != nil {
            return self.fixNull(object: field)
        }
        return nil
    }
    class func checkStringOrDecimalNumberToString(checkedObject: AnyObject?) -> String? {
        if (checkedObject is String) { return checkedObject as? String}
        else if (checkedObject is NSNumber) {
            return String(format:"%lld", (checkedObject as! NSNumber).int64Value)
        }
        else { return nil }
    }
    class func checkStringOrDecimalNumberToNumber(checkedObject: AnyObject?) -> NSNumber? {
        if (checkedObject is NSNumber) { return checkedObject as? NSNumber}
        else if (checkedObject is String) {
            return NSNumber(value:Int((checkedObject as! String))!)
        }
        else { return nil }
    }
}
