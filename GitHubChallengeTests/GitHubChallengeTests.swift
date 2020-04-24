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
    var systemUnderTest: GitHubTableViewCell!
    
    override func setUp() {
        super.setUp()
        systemUnderTest = GitHubTableViewCell()
    }
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }
    
    func testResponseCodeWhenFunctionBeCalled(){
        //the Function is loadGitHubList
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
        XCTAssertEqual(statusCodeSucess, statusCodeValue, "the value must be equals to \(statusCodeSucess)")
    }
    
    func testPrepareOfTheCells(){
        XCTAssertTrue(systemUnderTest.lbAutorName?.text != "nome autor", "Autor Name don`t took the name in the REST call")
        XCTAssertTrue(systemUnderTest.lbRepositoryName?.text != "nome repo", "Repo Name don't took the Repo Name in the REST call")
        XCTAssertTrue(systemUnderTest.lbStarsQtd?.text != "qtd stars", "Stars qtd don't took the qtd stars in the REST call")
        XCTAssertTrue(systemUnderTest.ivAutor != nil, "The image can't be nil")
    }
    
    func testloadImageFromURL(){
        
    }
}
