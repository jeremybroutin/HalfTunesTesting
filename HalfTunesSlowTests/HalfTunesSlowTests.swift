//
//  HalfTunesSlowTests.swift
//  HalfTunesSlowTests
//
//  Created by Jeremy Broutin on 4/5/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import HalfTunes

class HalfTunesSlowTests: XCTestCase {

  var sessionUnderTest: URLSession!

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
    sessionUnderTest = URLSession(configuration: .default)
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    sessionUnderTest = nil
    super.tearDown()
  }

  func testValidCallToiTunesGetsHTTPStatusCode200() {
    // Given or Arrange or Assemble
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
    let promise = expectation(description: "Completion handler invoked")
    var statusCode: Int?
    var responseError: Error?
    // When or Act or Activate
    let dataTask = sessionUnderTest.dataTask(with: url!) { (data, response, error) in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    waitForExpectations(timeout: 5, handler: nil)
    // Then or Assert
    XCTAssertNil(responseError)
    XCTAssertEqual(statusCode, 200)
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
