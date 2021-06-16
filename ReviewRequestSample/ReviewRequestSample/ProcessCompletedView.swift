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
    
    @State private var selectedRating: Int = 0
    private var maximumRating = 5
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Process Completed")
                .font(.system(size: 24))
                .padding()
            
            HStack {
            Spacer()

                ForEach(1 ..< maximumRating + 1) { ratingNumber in
                    Image(systemName: ratingNumber > selectedRating ? "star" : "star.fill")
                        .foregroundColor(ratingNumber > selectedRating ? Color.gray : Color.blue)
                        .onTapGesture {
                            selectedRating = ratingNumber
                        }
                }
            }
            
            Button("Start Over") {
                presentationMode.wrappedValue.dismiss()
                
                // 高評価の場合はレビュー依頼画面を表示
                if selectedRating > 3 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                        if let windowScene = UIApplication.shared.windows.first?.windowScene {
                            SKStoreReviewController.requestReview(in: windowScene)
                        }
                    }
                }
            }
            .font(.system(size: 20))
            
            Spacer()
        }
        .navigationTitle("Completed View")
    }
}

struct ProcessCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCompletedView()
    }
}
