//
//  GitHubChallengeTests.swift
//  GitHubChallengeTests
//
//  Created by Kaique Alves on 16/04/20.
//  Copyright © 2020 Kaique Alves. All rights reserved.
//

import XCTest
@testable import GitHubChallenge

class GitHubChallengeTests: XCTestCase {
    
    func testResponseCode(){
        var statusCodeValue = 0
        let statusCodeSucess = 200
        let expectation = self.expectation(description: "testing")
        
        REST.loadAGitHubList(onComplete: { (github, statusCode) in
            statusCodeValue = statusCode
            expectation.fulfill()
        }) { (error) in
            statusCodeValue = 404
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(statusCodeSucess, statusCodeValue)
    }
}
