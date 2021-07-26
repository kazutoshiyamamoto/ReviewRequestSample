//
//  ContentView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI

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
                viewModel.canRequestReview()
            })
                    if let windowScene = UIApplication.shared.windows.first?.windowScene {
                    }
                }
            })
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView(viewModel: InitialViewModel())
    }
}
