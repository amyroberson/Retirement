//
//  RetirementTests.swift
//  RetirementTests
//
//  Created by Amy Roberson on 12/23/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest

class RetirementTests: XCTestCase {
    
    func testEvaluateYNYes(){
        XCTAssertEqual(evaluateYN(input: "yes"), true)
        XCTAssertEqual(evaluateYN(input: "y"), true)
        XCTAssertEqual(evaluateYN(input: "Y"), true)
        XCTAssertEqual(evaluateYN(input: "Yes"), true)
    }
    
    func testEvaluateYNNo(){
        XCTAssertFalse(evaluateYN(input: "no"))
        XCTAssertFalse(evaluateYN(input: "n"))
        XCTAssertFalse(evaluateYN(input: "Not"))
        XCTAssertFalse(evaluateYN(input: "nope"))
    }
    
    func testToJson(){
        var dictionary: [String: Person] = [:]
        dictionary["Amy"] = Person(name: "Amy", age: 25, ageToRetire: 65)
        do {
            let expected = "{\"Amy\":{\"name\":\"Amy\",\"age\":25,\"retirementAge\":65}}"
            let data: Data = try toJSON(people: dictionary)
            let s = String(data: data, encoding: .utf8)!
            XCTAssertEqual(s, expected)
        } catch {
            XCTAssert(false)
        }
    }
    
}
