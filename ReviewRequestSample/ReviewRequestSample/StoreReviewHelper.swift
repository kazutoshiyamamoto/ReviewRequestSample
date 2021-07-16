//
//  StoreReviewHelper.swift
//  ReviewRequestSample
//
//  Created by home on 2021/07/16.
//

import Foundation

struct StoreReviewHelper {
    // StoreReviewHelperで使用するUserDefaultsKeyの一覧
    enum UserDefaultsKeys {
        // 初回設定の完了状況を管理するキー
        static let isStoreReviewHelperConfigured = "isStoreReviewHelperConfigured"
        // レビュー依頼対象か管理するキー
        static let isReviewRequestCandidate = "isReviewRequestCandidate"
        // アプリを開いた回数を管理するキー
        static let appOpenCount = "appOpenCount"
        // 完了画面を表示した回数を管理するキー
        static let processCompletedCount = "processCompletedCount"
        // 最後にレビュー依頼を行った日時を管理するキー
        static let lastReviewRequestDate = "lastReviewRequestDate"
    }
    
    // レビュー依頼候補者に設定
    static func configure() {
        // 初回起動時のみ実行する
        if !UserDefaults.standard.bool(forKey: UserDefaultsKeys.isStoreReviewHelperConfigured) {
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isReviewRequestCandidate)
            print("レビュー候補者に設定")
            
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isStoreReviewHelperConfigured)
        } else {
            print("レビュー依頼初期設定済み")
        }
    }
    
}
