//
//  UtilTests.swift
//  Retirement
//
//  Created by Amy Roberson on 12/23/16.
//  Copyright © 2016 Amy Roberson. All rights reserved.
//

import XCTest

class UtilTests: XCTestCase {

    func testGetCurrentYear(){
        let result = Util.getCurrentYear()
        let expected = 2016
        XCTAssert(result == expected)
    }

}
