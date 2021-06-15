//
//  ProcessCompletedView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI
import StoreKit

struct ProcessCompletedView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedRating: Int = 0
    var body: some View {
        VStack {
            Text("Process Completed")
                .font(.system(size: 24))
                .padding()
            
            Button("Start Over") {
                presentationMode.wrappedValue.dismiss()
                
                // レビュー依頼画面を表示
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                    if let windowScene = UIApplication.shared.windows.first?.windowScene {
                        SKStoreReviewController.requestReview(in: windowScene)
                    }
                }
            }
            .font(.system(size: 20))
        }
        .navigationTitle("Completed View")
    }
}

struct ProcessCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCompletedView()
    }
}
