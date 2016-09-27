//
//  Date.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

extension Date {
    var firstOfMonth: Date? {
        /// Return a new Date by setting this Date's day to first.
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return calendar.date(from: components)
    }
    
    /// Return a new Date by setting this Date's day to last.
    var lastOfMonth: Date? {
        guard let firstOfMonth = firstOfMonth else { return nil }
        
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        components.day = -1
        
        return calendar.date(byAdding: components, to: firstOfMonth)
    }
    
    /// Return a new Date by setting this Date's day and month to first.
    var firstOfYear: Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        
        return calendar.date(from: components)
    }
    
    /// Return a new Date by setting this Date's day and month to last.
    var lastOfYear: Date? {
        guard let firstOfYear = firstOfYear else { return nil }
        
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = -1
        components.day = -1
        
        return calendar.date(byAdding: components, to: firstOfYear)
    }
    
    /**
     A weekday or count of weekdays.
     
     - note: This value is interpreted in the context of the current calendar.
     */
    var weekday: Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        
        return components.weekday
    }
}
