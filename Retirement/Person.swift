//
//  Person.swift
//  Retirement
//
//  Created by Amy Roberson on 12/23/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import Foundation


class Person: Equatable {

    let name: String
    let age: Int
    let retirementAge: Int
    
    init(name: String, age: Int, ageToRetire: Int){
        precondition(age < ageToRetire)
        self.name = name
        self.age = age
        self.retirementAge = ageToRetire
    }
    
    init?(dictionary: [String: Any]){
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name
        guard let tmpAge = dictionary["age"] as? Int else {return nil}
        self.age = tmpAge
        guard let rAge = dictionary["retirementAge"] as? Int else {return nil}
        self.retirementAge = rAge
        
    }
    

    func calculateYearOfRetirement() -> Int {
        let yearTillRetirement = self.yearsTillRetirement()
        let currentYear = Util.getCurrentYear()
        let yearToRetire = currentYear + yearTillRetirement
        return yearToRetire
    }

    func yearsTillRetirement() -> Int { // needs testing
        return (self.retirementAge - self.age)
    }
    
    func toDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "name" : self.name,
            "age" : self.age,
            "retirementAge" : self.retirementAge
        ]
        return dictionary
    }
    
    static func == (_ lhs: Person, _ rhs: Person) -> Bool{
        return rhs.age == lhs.age && lhs.name == rhs.name && lhs.retirementAge == rhs.retirementAge
    }
    
}
