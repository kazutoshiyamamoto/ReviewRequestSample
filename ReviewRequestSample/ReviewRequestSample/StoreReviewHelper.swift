//
//  StoreReviewHelper.swift
//  ReviewRequestSample
//
//  Created by home on 2021/07/25.
//

import Foundation

enum ReviewRequestState: String {
    case candidate = "candidate" // アプリレビュー依頼候補者
    case notCandidate = "notCandidate" // アプリレビュー依頼対象外
    case notConfigured = "" // 初回起動時（CandidateState未設定）
}

// アプリレビュー依頼のタイミングを補助するクラス
final class StoreReviewHelper {
    
    static let shared: StoreReviewHelper = {
        let dataStore = UserDefaultsDataStore(userDefaults: UserDefaults.standard)
        let storeReviewHelper = StoreReviewHelper(dataStore: dataStore)
        return storeReviewHelper
    }()
    
    var dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    // 初回起動時にアプリレビュー依頼候補者に設定
    func configure() {
        dataStore.fetchCandidateState() { state in
            switch state {
            case .notConfigured:
                dataStore.saveCandidateState(state: ReviewRequestState.candidate)
            default:
                break
            }
        }
    }
    
    // アプリを開いた回数を更新
    func updateAppOpenCount() {
        dataStore.fetchCandidateState() { state in
            print("取得した状態(updateAppOpenCount):\(state)")
            switch state {
            case .candidate:
                let appOpenedCount = dataStore.fetchAppOpenedCount()
                let updatedAppOpenCount = appOpenedCount + 1
                dataStore.saveAppOpenedCount(count: updatedAppOpenCount)
                print("アプリを開いた回数:\(dataStore.fetchAppOpenedCount())回")
            default:
                break
            }
        }
    }
    
    // 完了画面を表示した回数を更新
    func updateProcessCompletedCount() {
        dataStore.fetchCandidateState() { state in
            print("取得した状態(updateProcessCompletedCount):\(state)")
            switch state {
            case .candidate:
                let processCompletedCount = dataStore.fetchProcessCompletedCount()
                let updatedProcessCompletedCount = processCompletedCount + 1
                dataStore.saveProcessCompletedCount(count: updatedProcessCompletedCount)
                print("完了画面を表示した回数:\(dataStore.fetchProcessCompletedCount())回")
            default:
                break
            }
        }
    }
    
    func removeFromCandidate() {
        dataStore.fetchCandidateState() { state in
            print("取得した状態(removeFromCandidate):\(state)")
            switch state {
            case .candidate:
                dataStore.saveCandidateState(state: .notCandidate)
                
                // アプリレビュー依頼画面表示の判定に使用していた値を破棄
                dataStore.removeAppOpenedCount()
                dataStore.removeProcessCompletedCount()
                dataStore.removeLastReviewRequestDate()
                
                print("レビュー依頼候補から外した\n起動回数:\(String(describing: dataStore.fetchAppOpenedCount()))回\n完了画面を表示した回数:\(String(describing: dataStore.fetchProcessCompletedCount()))回\n最後にレビュー依頼をした日付:\(String(describing: dataStore.fetchLastReviewRequestDate())))")
            default:
                break
            }
        }
    }
    
    // アプリレビュー依頼が可能か（表示条件を満たすか）確認
    func canRequestReview(completion: (Bool) -> Void) {
        dataStore.fetchCandidateState() { state in
            print("取得した状態(canRequestReview):\(state)")
            switch state {
            case .candidate:
                if let lastReviewRequestDate = dataStore.fetchLastReviewRequestDate() as? Date {
                    // 前回のレビュー依頼日から中1ヶ月が経過しているかどうかを確認
                    var calendar = Calendar.current
                    calendar.locale = .current
                    calendar.timeZone = .current
                    guard let nextReviewRequestDate = calendar.date(byAdding: .month, value: 1, to: calendar.startOfDay(for: lastReviewRequestDate)) else {
                        return
                    }
                    print("次回の依頼日\(String(describing: nextReviewRequestDate))")
                    
                    let today = calendar.startOfDay(for: Date())
                    let isRequestable = today > nextReviewRequestDate ? true : false
                    completion(isRequestable)
                } else {
                    // 2回以上アプリを開いていて、完了画面を3回以上表示しているかどうかを確認
                    let appOpenedCount = dataStore.fetchAppOpenedCount()
                    let processCompletedCount = dataStore.fetchProcessCompletedCount()
                    let isRequestable = appOpenedCount >= 2 && processCompletedCount >= 3 ? true : false
                    completion(isRequestable)
                }
            default:
                completion(false)
            }
        }
    }
    
    func saveLastReviewRequestDate() {
        self.dataStore.saveLastReviewRequestDate(date: Date())
    }
}
