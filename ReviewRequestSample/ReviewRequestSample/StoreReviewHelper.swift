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
    
    // TODO:increment処理の共通化（UserDefaultsを拡張する？やり方調べる）
    // アプリを開いた回数を1追加する
    static func incrementAppOpenCount() {
        var appOpenCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)
        appOpenCount += 1
        UserDefaults.standard.set(appOpenCount, forKey: UserDefaultsKeys.appOpenCount)
        print("アプリを開いた回数\(appOpenCount)回")
    }
    
    // 完了画面を表示した回数を1追加する
    static func incrementProcessCompletedCount() {
        var processCompletedCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)
        processCompletedCount += 1
        UserDefaults.standard.set(processCompletedCount, forKey: UserDefaultsKeys.processCompletedCount)
        print("完了画面を表示した回数\(processCompletedCount)回")
    }
    
    // レビュー依頼候補から外す
    static func removeFromCandidate() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isReviewRequestCandidate)
        
        // レビュー依頼画面表示の判定に使用していた値を破棄
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.appOpenCount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.processCompletedCount)
        
        print("レビュー依頼候補から外した")
        print("起動回数:\(String(describing: UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)))回")
        print("完了画面を表示した回数:\(String(describing: UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)))回")
    }
}
