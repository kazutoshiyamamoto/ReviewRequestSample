//
//  UserDefaultsDataStore.swift
//  ReviewRequestSample
//
//  Created by home on 2021/07/25.
//

import Foundation

protocol DataStoreProtocol {
    func fetchReviewRequestState(completion: (ReviewRequestState) -> Void)
    func fetchAppOpenedCount() -> Int
    func fetchProcessCompletedCount() -> Int
    func fetchLastReviewRequestDate() -> Any?
    
    func saveReviewRequestState(state: ReviewRequestState)
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
    
    // MARK: アプリレビュー依頼の判定に使用する情報の管理
    func fetchReviewRequestState(completion: (ReviewRequestState) -> Void) {
        let reviewRequestState = userDefaults.string(forKey: "reviewRequestState") ?? ""
        switch reviewRequestState {
        case "target":
            completion(ReviewRequestState.target)
        case "notTarget":
            completion(ReviewRequestState.notTarget)
        default:
            completion(ReviewRequestState.unknown)
        }
    }
    
    func fetchAppOpenedCount() -> Int {
        return userDefaults.integer(forKey: "appOpenedCount")
    }
    
    func fetchProcessCompletedCount() -> Int {
        return userDefaults.integer(forKey: "processCompletedCount")
    }
    
    func fetchLastReviewRequestDate() -> Any? {
        return userDefaults.object(forKey: "lastReviewRequestDate")
    }
    
    func saveReviewRequestState(state: ReviewRequestState) {
        switch state {
        case .target:
            print("保存する値:\(state.rawValue)")
            userDefaults.set(state.rawValue, forKey: "reviewRequestState")
        case .notTarget:
            print("保存する値:\(state.rawValue)")
            userDefaults.set(state.rawValue, forKey: "reviewRequestState")
        default:
            break
        }
    }
    
    func saveAppOpenedCount(count: Int) {
        userDefaults.set(count, forKey: "appOpenedCount")
    }
    
    func saveProcessCompletedCount(count: Int) {
        userDefaults.set(count, forKey: "processCompletedCount")
    }
    
    func saveLastReviewRequestDate(date: Date) {
        userDefaults.set(date, forKey: "lastReviewRequestDate")
    }
    
    func removeAppOpenedCount() {
        userDefaults.removeObject(forKey: "appOpenedCount")
    }
    
    func removeProcessCompletedCount() {
        userDefaults.removeObject(forKey: "processCompletedCount")
    }
    
    func removeLastReviewRequestDate() {
        userDefaults.removeObject(forKey: "lastReviewRequestDate")
    }
}
