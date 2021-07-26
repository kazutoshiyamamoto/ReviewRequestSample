//
//  StoreReviewHelper.swift
//  ReviewRequestSample
//
//  Created by home on 2021/07/25.
//

import Foundation
import StoreKit

enum ReviewCandidateState: String {
    case candidate = "candidate" // アプリレビュー依頼候補者
    case notCandidate = "notCandidate" // アプリレビュー依頼対象外
    case notConfigured = "" // 初回起動時（CandidateState未設定）
}

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
                dataStore.saveCandidateState(state: ReviewCandidateState.candidate)
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
    
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
