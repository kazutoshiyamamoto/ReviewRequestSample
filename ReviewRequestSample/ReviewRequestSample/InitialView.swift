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
            NavigationLink(destination: ProcessCompletedView()) {
                Text("Start Process")
                        .font(.system(size: 30))
            }
            .onAppear(perform: {
                let count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCountKey)
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
