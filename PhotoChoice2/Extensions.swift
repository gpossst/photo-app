//
//  Extensions.swift
//  PhotoChoice2
//
//  Created by Garrett Post on 3/15/24.
//

import Foundation

extension Array {
    func shiftRight(amount: Int = 1) -> [Element] {
        var newAmt = amount
        guard count > 0 else { return self }
        assert(-count...count ~= newAmt, "Shift amount out of bounds")
        if newAmt < 0 { newAmt += count }  // this needs to be >= 0
        return Array(self[newAmt ..< count] + self[0 ..< newAmt])
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfWeek: Date {
        Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    var endOfWeek: Date {
        var components = DateComponents()
        components.weekOfYear = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfWeek)!
    }
    
    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
}


