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
    
    }
    
    }
    
            }
        }
    }
    
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
