//
//  ContentView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI
import StoreKit

struct InitialView: View {
    @ObservedObject private var viewModel: InitialViewModel
    
    init(viewModel: InitialViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                NavigationLink(destination: ProcessCompletedView()) {
                    Text("Start Process")
                        .font(.system(size: 30))
                        .padding()
                }
                
                if let writeReviewURL = URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review") {
                    Link("Write a Review", destination: writeReviewURL)
                        .font(.system(size: 18))
                }
                
                Spacer()
            }
            .onAppear(perform: {
                viewModel.canRequestReview()
            })
            .onChange(of: viewModel.isReviewRequestable) { isReviewRequestable in
                if isReviewRequestable {
                    if let windowScene = UIApplication.shared.windows.first?.windowScene {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                            SKStoreReviewController.requestReview(in: windowScene)
                            StoreReviewHelper.shared.saveLastReviewRequestDate()
                        }
                    }
                }
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView(viewModel: InitialViewModel())
    }
}
