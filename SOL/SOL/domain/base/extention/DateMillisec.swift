//
//  DateMillisec.swift
//  SOL
//
//  Created by Rostislav Maslov on 28.09.2021.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    var timezone: Int {
        return TimeZone.current.secondsFromGMT() / 60 / 60
    }
    
    var beautify: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short        
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
