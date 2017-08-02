//
//  Date.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension Date {
    /// The day of the date.
    public var day: Int {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: self)
            
            return components.day ?? 0
        }
        set {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            components.day = newValue
            guard let newDate = calendar.date(from: components) else { return }
            
            self = newDate
        }
    }
    
    /// The month of the date.
    public var month: Int {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.month], from: self)
            
            return components.month ?? 0
        }
        set {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            components.month = newValue
            guard let newDate = calendar.date(from: components) else { return }
            
            self = newDate
        }
    }
    
    /// The year of the date.
    public var year: Int {
        get {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year], from: self)
            
            return components.year ?? 0
        }
        set {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            components.year = newValue
            guard let newDate = calendar.date(from: components) else { return }
            
            self = newDate
        }
    }
    
    /// Returns a new Date by setting this Date's day to first.
    public var firstOfMonth: Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return calendar.date(from: components)
    }
    
    /// Returns a new Date by setting this Date's day to last.
    public var lastOfMonth: Date? {
        guard let firstOfMonth = firstOfMonth else { return nil }
        
        var components = DateComponents()
        components.month = 1
        components.day = -1
        
        return Calendar.current.date(byAdding: components, to: firstOfMonth)
    }
    
    /// Returns a new Date by setting this Date's day and month to first.
    public var firstOfYear: Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        
        return calendar.date(from: components)
    }
    
    /// Returns a new Date by setting this Date's day and month to last.
    public var lastOfYear: Date? {
        guard let firstOfYear = firstOfYear else { return nil }
        
        var components = DateComponents()
        components.year = 1
        components.day = -1
        
        return Calendar.current.date(byAdding: components, to: firstOfYear)
    }
    
    /// Returns a new Date with the day following this Date.
    public var nextDay: Date? {
        var components = DateComponents()
        components.day = 1
        
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// Returns a new Date with the day preceding this Date.
    public var previousDay: Date? {
        var components = DateComponents()
        components.day = -1
        
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /**
     Returns a weekday or count of weekdays.
     
     - note: This value is interpreted in the context of the current calendar.
     */
    public var weekday: Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        
        return components.weekday
    }
}
