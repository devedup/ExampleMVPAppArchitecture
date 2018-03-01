//
//  CSExampleTests.swift
//  CSExampleTests
//
//  Created by David Casserly on 26/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import XCTest
@testable import CSExample

class ScoreViewTests: XCTestCase {
    
    // MARK: Model Tests

    func testScoreModelFromNetworkModel_expectValidModel() {
        // Setup some network data
        let creditReportInfo = ScoreServiceNetworkResponse.CreditReportInfo(score: 0, maxScoreValue: 500, minScoreValue: 0)
        let networkScore = ScoreServiceNetworkResponse(creditReportInfo: creditReportInfo)
        
        // Create model
        let model = ScoreModel(networkScore)
        
        XCTAssertNotNil(model, "We should have a valid model")
    }
    
    func testScoreModelFromNetworkModel_expectInvalidModel() {
        // Setup some network data - max score is LOWER than min
        let creditReportInfo = ScoreServiceNetworkResponse.CreditReportInfo(score: 0, maxScoreValue: 500, minScoreValue: 1000)
        let networkScore = ScoreServiceNetworkResponse(creditReportInfo: creditReportInfo)
        
        // Create model
        let model = ScoreModel(networkScore)
        
        XCTAssertNil(model, "We should have an invalid model as the min score is higher than the max")
    }
    
    func testScoreModelFromNetworkModel_expectInvalidModel_scoreNotWithinRange() {
        // Setup some network data - max score is LOWER than min
        let creditReportInfo = ScoreServiceNetworkResponse.CreditReportInfo(score: 700, maxScoreValue: 500, minScoreValue: 0)
        let networkScore = ScoreServiceNetworkResponse(creditReportInfo: creditReportInfo)
        
        // Create model
        let model = ScoreModel(networkScore)
        
        XCTAssertNil(model, "We should have an invalid model as the score is higher than the max")
    }
    
    // MARK: Presenter Tests
    
    func testServiceFailure_expectDidPresentError() {
        // Create presenter
        let mockView = MockScorePresenterView()
        let networkExpectation = expectation(description: "Waiting for callback")
        let errorScoreService = DummyErrorService()
        errorScoreService.expectation = networkExpectation
        let presenter = ScorePresenter(view: mockView, service: errorScoreService)
        
        // Load score data, which will return an error and sent it back to the view
        presenter.loadScoreData()
        
        //Check expectations
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(mockView.didPresentError)
    }
    
}

/// This mock can be used to determine which methods were called on the Presenter, it can be expanded to cover the other methods when the tests are filled out
private class MockScorePresenterView: ScorePresenterView {
    
    var didPresentError: Bool = false
    
    func present(scoreData: ScoreViewModel) {}
    
    func present(_ error: ClearScoreError) {
        didPresentError = true
    }
    
    func presentActivityIndicator() {}

    func dismissActivityIndicator() {}
    
}

/// This implementation of ScoreService will always return an error
private class DummyErrorService: ScoreService {
    
    /// It's a unit test dummy, so the implicit unwrapping is fine here
    var expectation: XCTestExpectation!
    
    func loadScoreData(completion: @escaping AsyncResultCompletion<ScoreModel>) {
        // Just return an error
        expectation.fulfill()
        completion(AsyncResult.failure(ClearScoreError.generalNetworkError(nil)))
    }
    
}



