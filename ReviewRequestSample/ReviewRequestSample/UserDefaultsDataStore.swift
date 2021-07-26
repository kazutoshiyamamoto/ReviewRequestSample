//
//  UserDefaultsDataStore.swift
//  ReviewRequestSample
//
//  Created by home on 2021/07/25.
//

import Foundation

protocol DataStoreProtocol {
    func fetchCandidateState(completion: (ReviewCandidateState) -> Void)
    func fetchAppOpenedCount() -> Int
    func fetchProcessCompletedCount() -> Int
    func fetchLastReviewRequestDate() -> Any?
    
    func saveCandidateState(state: ReviewCandidateState)
    func saveAppOpenedCount(count: Int)
    func saveProcessCompletedCount(count: Int)
    func saveLastReviewRequestDate(date: Date)
    
    func removeAppOpenedCount()
    func removeProcessCompletedCount()
    func removeLastReviewRequestDate()
}

final class UserDefaultsDataStore: DataStoreProtocol {
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
}
