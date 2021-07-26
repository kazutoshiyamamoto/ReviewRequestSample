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
    
    
    var dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
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
