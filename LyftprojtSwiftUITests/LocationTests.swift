//
//  LyftprojtSwiftUITests.swift
//  LyftprojtSwiftUITests
//
//  Created by Jonathan Zheng on 3/6/24.
//

import XCTest
@testable import LyftprojtSwiftUI

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
    }

    func testNameDifference() throws {
        let location1 = Location(title: "SF", subtitle: "SF", lat: 37.787359, lng: -122.408227)
        let location2 = Location(title: "San Jose", subtitle: "SF", lat: 37.787359, lng: -122.408227)
        XCTAssertFalse(location1 == location2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
