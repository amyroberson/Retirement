//
//  FileInteraction.swift
//  Retirement
//
//  Created by Amy Roberson on 12/27/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest

class FileInteraction: XCTestCase {

    func testSaveloadHistory(){
        var dictionary: [String: Person] = [:]
        dictionary["Amy"] = Person(name: "Amy", age: 25, ageToRetire: 65)
        dictionary["Bob"] = Person(name: "Bob", age: 40, ageToRetire: 70)
        saveHistory(people: dictionary)
        let newDictionary = loadHistory()
        let result1 = newDictionary["Amy"]!
        let result2 = newDictionary["Bob"]!
        XCTAssertEqual(result1, Person(name: "Amy", age: 25, ageToRetire: 65))
        XCTAssertEqual(result2, Person(name: "Bob", age: 40, ageToRetire: 70))
    }

}
