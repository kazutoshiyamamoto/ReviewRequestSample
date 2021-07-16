//
//  ProcessCompletedView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI

struct ProcessCompletedView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedRating: Int = 0
    @State private var isLogSended = false
    private var maximumRating = 5
    private var rankTexts = ["", "不満", "", "", "", "満足", ""]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Process Completed")
                .font(.system(size: 30))
                .padding()
            
            HStack(spacing: 25) {
                ForEach(1 ..< maximumRating + 1) { ratingNumber in
                    VStack {
                        Image(systemName: ratingNumber > selectedRating ? "star" : "star.fill")
                            .foregroundColor(Color("ratingIconColor"))
                            .onTapGesture {
                                selectedRating = ratingNumber
                                
                                //                                print("評価送信:\(String(describing: ratingNumber))")
                                
                                // 査定金額で低評価を選択した場合はアプリのストアレビュー候補から外す
                                if UserDefaults.standard.bool(forKey: StoreReviewHelper.UserDefaultsKeys.isReviewRequestCandidate) && (ratingNumber == 1 || ratingNumber == 2) {
                                    StoreReviewHelper.removeFromCandidate()
                                }
                            }
                            .font(.title2)
                        
                        Text(rankTexts[ratingNumber])
                            .font(.subheadline)
                    }
                }
            }
            .frame(width: 300)
            .padding(.bottom, 20)
            
            if let linkURL = URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review") {
                Link("Link", destination: linkURL)
                    .font(.system(size: 18))
                    .padding(.bottom, 20)
            }
            
            Button("Start Over") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.system(size: 18))
            
            Spacer()
        }
        .onAppear(perform: {
            var count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCountKey)
            count += 1
            UserDefaults.standard.set(count, forKey: UserDefaultsKeys.processCompletedCountKey)
            print("Process completed \(count) time(s)")
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("sceneDidEnterBackground"))) { _ in
            print("sceneDidEnterBackground")
            if isLogSended == false {
                logSend()
                isLogSended = true
            }
        }
        .onDisappear(perform: {
            print("onDisappear")
            if isLogSended == false {
                logSend()
                isLogSended = true
            }
        })
    }
    
    private func logSend() {
        print("評価送信:\(String(describing: selectedRating != 0 ? selectedRating : nil))")
    }
}

struct ProcessCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCompletedView()
    }
}
