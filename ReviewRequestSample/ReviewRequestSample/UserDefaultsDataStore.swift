//
//  UserDefaultsDataStore.swift
//  ReviewRequestSample
//
//  Created by home on 2021/07/25.
//

import Foundation

protocol DataStoreProtocol {
    // MARK: アプリレビュー依頼の判定に使用
    func fetchReviewRequestState(completion: (ReviewRequestState) -> Void)
    func fetchAppOpenedCount() -> Int
    func fetchProcessCompletedCount() -> Int
    func fetchLastReviewRequestDate() -> Date?
    
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
        case "candidate":
            completion(ReviewRequestState.candidate)
        case "notCandidate":
            completion(ReviewRequestState.notCandidate)
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
    
    func fetchLastReviewRequestDate() -> Date? {
        return userDefaults.object(forKey: "lastReviewRequestDate") as? Date
    }
    
    func saveReviewRequestState(state: ReviewRequestState) {
        switch state {
        case .candidate:
            print("保存する値:\(state.rawValue)")
            userDefaults.set(state.rawValue, forKey: "reviewRequestState")
        case .notCandidate:
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
