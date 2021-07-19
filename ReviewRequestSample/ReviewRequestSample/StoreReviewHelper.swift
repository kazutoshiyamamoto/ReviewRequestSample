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
        static let StoreReviewHelperConfigured = "storeReviewHelperConfigured"
        // レビュー依頼対象か管理するキー
        static let ReviewRequestCandidate = "reviewRequestCandidate"
        // アプリを開いた回数を管理するキー
        static let appOpenCount = "appOpenCount"
        // 完了画面を表示した回数を管理するキー
        static let processCompletedCount = "processCompletedCount"
        // 最後にレビュー依頼を行った日時を管理するキー
        static let lastReviewRequestDate = "lastReviewRequestDate"
    }
    
    // レビュー依頼候補者に設定
    static func configure() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.ReviewRequestCandidate)
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.StoreReviewHelperConfigured)
        print("レビュー候補者に設定")
    }
    
    // TODO:increment処理の共通化（UserDefaultsを拡張する？やり方調べる）
    // アプリを開いた回数を1追加する
    static func incrementAppOpenCount() {
        var appOpenCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)
        appOpenCount += 1
        UserDefaults.standard.set(appOpenCount, forKey: UserDefaultsKeys.appOpenCount)
        print("アプリを開いた回数:\(appOpenCount)回")
    }
    
    // 完了画面を表示した回数を1追加する
    static func incrementProcessCompletedCount() {
        var processCompletedCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)
        processCompletedCount += 1
        UserDefaults.standard.set(processCompletedCount, forKey: UserDefaultsKeys.processCompletedCount)
        print("完了画面を表示した回数:\(processCompletedCount)回")
    }
    
    // レビュー依頼候補から外す
    static func removeFromCandidate() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.ReviewRequestCandidate)
        
        // レビュー依頼画面表示の判定に使用していた値を破棄
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.appOpenCount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.processCompletedCount)
        
        print("レビュー依頼候補から外した\n起動回数:\(String(describing: UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)))回\n完了画面を表示した回数:\(String(describing: UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)))回\n最後にレビュー依頼をした日付:\(String(describing: UserDefaults.standard.object(forKey: UserDefaultsKeys.lastReviewRequestDate)))")
    }
}
