//
//  InitialViewModel.swift
//  ReviewRequestSample
//
//  Created by home on 2021/07/26.
//

import Foundation

final class InitialViewModel: ObservableObject {
    @Published var isReviewRequestable = false
    
    func canRequestReview() {
        StoreReviewHelper.shared.canRequestReview() {
            isReviewRequestable = $0
        }
    }
}
