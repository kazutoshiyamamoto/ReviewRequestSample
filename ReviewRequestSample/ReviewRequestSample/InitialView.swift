//
//  ContentView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI
import StoreKit

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
                let count = UserDefaults.standard.integer(forKey: StoreReviewHelper.UserDefaultsKeys.processCompletedCount)
                if count >= 2 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                        if let windowScene = UIApplication.shared.windows.first?.windowScene {
                            SKStoreReviewController.requestReview(in: windowScene)
                        }
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
