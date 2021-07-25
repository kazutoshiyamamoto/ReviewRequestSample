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
        static let isConfigured = "isConfigured"
        // レビュー依頼対象者か管理するキー
        static let isRequestCandidate = "isRequestCandidate"
        // アプリを開いた回数を管理するキー
        static let appOpenCount = "appOpenCount"
        // 完了画面を表示した回数を管理するキー
        static let processCompletedCount = "processCompletedCount"
        // 最後にレビュー依頼を行った日時を管理するキー
        static let lastReviewRequestDate = "lastReviewRequestDate"
    }
    
    // レビュー依頼候補者に設定
    static func configure() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isRequestCandidate)
        print("レビュー候補者に設定")
    }
    
    // アプリを開いた回数を保存する
    static func saveAppOpenCount() {
        let appOpenCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)
        let newAppOpenCount = appOpenCount + 1
        UserDefaults.standard.set(newAppOpenCount, forKey: UserDefaultsKeys.appOpenCount)
        print("アプリを開いた回数:\(newAppOpenCount)回")
    }
    
    // 完了画面を表示した回数を保存する
    static func saveProcessCompletedCount() {
        let processCompletedCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)
        let newProcessCompletedCount = processCompletedCount + 1
        UserDefaults.standard.set(newProcessCompletedCount, forKey: UserDefaultsKeys.processCompletedCount)
        print("完了画面を表示した回数:\(newProcessCompletedCount)回")
    }
    
    // 最後にレビュー依頼した日付を保存する
    static func saveLastReviewRequestDate() {
        let today = Date()
        UserDefaults.standard.set(today, forKey: UserDefaultsKeys.lastReviewRequestDate)
        print("最後にレビュー依頼をした日付:\(today))")
    }
    
    // レビュー依頼候補から外す
    // 評価1,2をつけた場合に呼ばれる
    static func removeFromCandidate() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isRequestCandidate)
        
        // レビュー依頼画面表示の判定に使用していた値を破棄
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.appOpenCount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.processCompletedCount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.lastReviewRequestDate)
        
        print("レビュー依頼候補から外した\n起動回数:\(String(describing: UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)))回\n完了画面を表示した回数:\(String(describing: UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)))回\n最後にレビュー依頼をした日付:\(String(describing: UserDefaults.standard.object(forKey: UserDefaultsKeys.lastReviewRequestDate)))")
    }
    
    // レビュー依頼条件を満たす状態かどうかを確認するメソッド
    // レビュー依頼したことがない場合は、2回以上アプリを開いていて、完了画面を3回以上表示しているかどうかを確認している
    // 初回れビュー表示以降は、前回のレビュー依頼日から中1ヶ月が経過しているかどうかを確認している
    static func canRequestReview() -> Bool {
        if let lastReviewRequestDate = UserDefaults.standard.object(forKey: StoreReviewHelper.UserDefaultsKeys.lastReviewRequestDate) as? Date {
            var calendar = Calendar.current
            calendar.locale = .current
            calendar.timeZone = .current
            guard let nextReviewRequestDate = calendar.date(byAdding: .month, value: 1, to: calendar.startOfDay(for: lastReviewRequestDate)) else {
                return false
            }
            print("次回の依頼日\(String(describing: nextReviewRequestDate))")
            
            let today = calendar.startOfDay(for: Date())
            let isRequestable = today > nextReviewRequestDate ? true : false
            return isRequestable
        } else {
            let appOpenCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.appOpenCount)
            let processCompletedCount = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCount)
            let isRequestable = appOpenCount >= 2 && processCompletedCount >= 3 ? true : false
            return isRequestable
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
