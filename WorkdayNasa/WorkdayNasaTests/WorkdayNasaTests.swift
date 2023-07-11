//
//  WorkdayNasaTests.swift
//  WorkdayNasaTests
//
//  Created by Mac on 11/07/23.
//

import XCTest
@testable import WorkdayNasa

class WorkdayNasaTests: XCTestCase {
    var expectation: XCTestExpectation!
    let timeout: TimeInterval = 2
    
    override func setUp() {
        expectation = expectation(description: "Server responds in reasonable time")
    }
    
    func test_decodeRoverData() {
        let url = URL(string: "https://images-api.nasa.gov/search?q=mars&media_type=image")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            XCTAssertNil(error)
            
            do {
                let response = try XCTUnwrap(response as? HTTPURLResponse)
                XCTAssertEqual(response.statusCode, 200)
                
                let data = try XCTUnwrap(data)
                XCTAssertNoThrow(
                    try JSONDecoder().decode(Collection.self, from: data)
                )
                
            } catch { }
        }
        .resume()
        
        waitForExpectations(timeout: timeout)
        
    }
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
}
