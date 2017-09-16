//
//  CommonDateFormatter.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 15.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class CommonDateFormatter: NSObject {
    static let dateComponentsFormatter: DateComponentsFormatter = {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.unitsStyle = DateComponentsFormatter.UnitsStyle.abbreviated
        dateFormatter.zeroFormattingBehavior = DateComponentsFormatter.ZeroFormattingBehavior.dropAll
        dateFormatter.maximumUnitCount = 1
        dateFormatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        return dateFormatter
    }()
    class func formattedTweetDate(date:Date)->String {
        return dateComponentsFormatter.string(from: date, to: Date())!
    }
    static let serverDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        dateFormatter.locale = Locale(identifier:"US")
        return dateFormatter
    }()
    class func dateFromServerString(serverString: String)->Date? {
        return serverDateFormatter.date(from: serverString)
    }
}
