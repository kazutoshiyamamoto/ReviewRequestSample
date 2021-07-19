//
//  StoreReviewHelper.swift
//  ReviewRequestSample
//
//  Created by home on 2021/07/16.
//

import Foundation
import StoreKit

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
    
    // 最後にレビュー依頼した日付を保存する
    static func storeLastReviewRequestDate() {
        let today = Date()
        UserDefaults.standard.set(today, forKey: UserDefaultsKeys.lastReviewRequestDate)
        print("最後にレビュー依頼をした日付:\(String(describing: UserDefaults.standard.object(forKey: UserDefaultsKeys.lastReviewRequestDate)!))")
    }
    
    // 前回のレビュー依頼日から1ヶ月が経過しているかどうかを確認
    // レビュー依頼したことがない場合は、2回以上アプリを開いていて、完了画面を3回以上表示しているかどうかを確認
    static func shouldReviewRequest() -> Bool {
        if let lastReviewRequestDate = UserDefaults.standard.object(forKey: StoreReviewHelper.UserDefaultsKeys.lastReviewRequestDate) as? Date {
            var calendar = Calendar.current
            calendar.locale = .current
            calendar.timeZone = .current
            guard let nextReviewRequestDate = calendar.date(byAdding: .month, value: 1, to: calendar.startOfDay(for: lastReviewRequestDate)) else {
                return false
            }
            
            let today = calendar.startOfDay(for: Date())
            
            print("次回の依頼日\(String(describing: nextReviewRequestDate))")
            print("今日の日付:\(today)")
            
            return today > nextReviewRequestDate ? true : false
        } else {
            let appOpenCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)
            let processCompletedCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)
            
            print("アプリを開いた回数:\(appOpenCount)回")
            print("完了画面を表示した回数:\(processCompletedCount)回")
            
            return appOpenCount >= 2 && processCompletedCount >= 3 ? true : false
        }
    }
    
    static func reviewRequest(windowScene: UIWindowScene) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    // レビュー依頼候補から外す
    // 評価1,2をつけた場合に呼ぶ
    static func removeFromCandidate() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.ReviewRequestCandidate)
        
        // レビュー依頼画面表示の判定に使用していた値を破棄
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.appOpenCount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.processCompletedCount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.lastReviewRequestDate)
        
        print("レビュー依頼候補から外した\n起動回数:\(String(describing: UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)))回\n完了画面を表示した回数:\(String(describing: UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)))回\n最後にレビュー依頼をした日付:\(String(describing: UserDefaults.standard.object(forKey: UserDefaultsKeys.lastReviewRequestDate)))")
    }
}
