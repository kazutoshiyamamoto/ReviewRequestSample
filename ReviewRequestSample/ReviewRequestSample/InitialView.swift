//
//  ContentView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI

struct InitialView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                NavigationLink(destination: ProcessCompletedView()) {
                    Text("Start Process")
                        .font(.system(size: 30))
                }
                
                Spacer()
                
                if let writeReviewURL = URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review") {
                    Link("Write a Review", destination: writeReviewURL)
                        .font(.system(size: 18))
                        .padding()
                }
                
                Button("Reset Sample") {
                    UserDefaults.standard.set(0, forKey: StoreReviewHelper.UserDefaultsKeys.processCompletedCount)
                    print("Count have been reset")
                }
                .font(.system(size: 18))
                .padding(.bottom, 40)
            }
            .onAppear(perform: {
                if UserDefaults.standard.bool(forKey: StoreReviewHelper.UserDefaultsKeys.ReviewRequestCandidate) && StoreReviewHelper.shouldReviewRequest() {
                    if let windowScene = UIApplication.shared.windows.first?.windowScene {
                        StoreReviewHelper.reviewRequest(windowScene: windowScene)
                        StoreReviewHelper.storeLastReviewRequestDate()
                    }
                }
            })
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
