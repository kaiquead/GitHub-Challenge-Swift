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
    var sut: GitHubTableViewCell!
    var tbVC: MainTableViewController!
    
    override func setUp() {
        super.setUp()
        sut = GitHubTableViewCell()
        tbVC = MainTableViewController()
    }
    
    override func tearDown() {
        sut = nil
        tbVC = nil
        super.tearDown()
    }
    
    func testResponseCodeWhenFunctionBeCalled(){
        //the Function is loadGitHubList
        var statusCodeValue = 0
        let statusCodeSucess = 200
        let expectation = self.expectation(description: "Status Code: 200")
        
        REST.loadAGitHubList(onComplete: { (github, statusCode) in
            statusCodeValue = statusCode
            expectation.fulfill()
        }) { (error) in
            statusCodeValue = 404
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(statusCodeSucess, statusCodeValue, "the value must be equals to \(statusCodeSucess) and the actual statusCode is \(statusCodeValue)")
    }
    
    func testPrepareCells (){
        
    }
    
}
