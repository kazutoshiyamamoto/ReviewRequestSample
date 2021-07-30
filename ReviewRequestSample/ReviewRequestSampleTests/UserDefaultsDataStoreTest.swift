//
//  UserDefaultsDataStoreTest.swift
//  ReviewRequestSampleTests
//
//  Created by home on 2021/07/30.
//

import XCTest
@testable import ReviewRequestSample

class UserDefaultsDataStoreTest: XCTestCase {

    var dataStore: UserDefaultsDataStore!

    override func setUp() {
        dataStore = UserDefaultsDataStore(userDefaults: UserDefaults.standard)
    }

    func testSaveReviewRequestState() {
        let reviewRequestState: ReviewRequestState = .candidate
        dataStore.saveReviewRequestState(state: reviewRequestState) { result in
            if case .success(let state) = result {
                XCTAssertEqual(state.rawValue, "candidate")
            } else {
                XCTFail("result must be a success.")
            }
        }
    }
}
