//
//  DateUtilities.swift
//  SampleCodeForTest
//
//  Created by iOSVenture LLC on 3/5/21.
//

import Foundation

extension String {
    var dateFromIS08086NSDate:Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        return date
    }
}
