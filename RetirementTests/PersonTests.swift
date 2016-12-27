//
//  PersonTests.swift
//  Retirement
//
//  Created by Amy Roberson on 12/23/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest


class PersonTests: XCTestCase {

    func testInitializePerson(){
        let bob = Person(name: "Bob", age: 35, ageToRetire: 65)
        XCTAssert(bob.age == 35)
        XCTAssert(bob.retirementAge == 65)
        XCTAssert(bob.name == "Bob")
    }
    
    func testYearOFRetirement(){
        let bob = Person(name: "Bob", age: 45, ageToRetire: 75)
        let expected = 2046
        let result = bob.calculateYearOfRetirement()
        XCTAssert(result == expected)
    }
    
    func testYearOFRetirement50(){
        let bobby = Person(name: "Bobby", age: 15, ageToRetire: 65)
        let expected = 2066
        let result = bobby.calculateYearOfRetirement()
        XCTAssert(result == expected)
    }
    
    func testToDictionary(){
        let bobby = Person(name: "Bobby", age: 15, ageToRetire: 65)
        let result = bobby.toDictionary()
        XCTAssertEqual(result["name"] as! String, "Bobby")
        XCTAssertEqual(result["age"] as! Int, 15)
        XCTAssertEqual(result["retirementAge"] as! Int, 65)
        
    }
    
    func testPersonInit(){
        let dictionary: [String: Any] = [
            "name" : "Nolan",
            "age" : 26,
            "retirementAge" : 55
        ]
        
        let nolan = Person(dictionary: dictionary)
        XCTAssertEqual(nolan?.age, 26)
        XCTAssertEqual(nolan?.name, "Nolan")
        XCTAssertEqual(nolan?.retirementAge, 55)
        
    }
    

}
