//
//  Util.swift
//  Retirement
//
//  Created by Amy Roberson on 12/23/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import Foundation


public struct Util {
    
    static func getCurrentYear()-> Int{
        let userCalender = Calendar.current
        let currentDate = Date()
        let currentDateComponets = userCalender.dateComponents( [.year], from: currentDate)
        let currentYear = currentDateComponets.year!
        return currentYear
    }
    
    
}
