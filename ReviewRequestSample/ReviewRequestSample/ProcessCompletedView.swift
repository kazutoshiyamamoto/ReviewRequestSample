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
                .font(.system(size: 30))
                .padding()
            
            HStack(spacing: 30) {
                ForEach(1 ..< maximumRating + 1) { ratingNumber in
                    Image(systemName: ratingNumber > selectedRating ? "star" : "star.fill")
                        .foregroundColor(ratingNumber > selectedRating ? Color.gray : Color.blue)
                        .onTapGesture {
                            selectedRating = ratingNumber
                        }
                        .font(.title)
                }
            }
            .padding([.bottom], 2)
            
            HStack(spacing: 30) {
                Text("不満")
                
                Spacer()
                
                Text("満足")
            }
            .frame(width: 300)
            
            Button("Link") {
                UIApplication.shared.open(URL(string: "https://qiita.com/")!)
                
                // 高評価の場合はレビュー依頼画面を表示
                if selectedRating > 3 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                        if let windowScene = UIApplication.shared.windows.first?.windowScene {
                            SKStoreReviewController.requestReview(in: windowScene)
                        }
                    }
                }
            }
            .font(.title3)
            .padding()
            
            Button("Start Over") {
                presentationMode.wrappedValue.dismiss()
                
//                // 高評価の場合はレビュー依頼画面を表示
//                if selectedRating > 3 {
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
//                        if let windowScene = UIApplication.shared.windows.first?.windowScene {
//                            SKStoreReviewController.requestReview(in: windowScene)
//                        }
//                    }
//                }
            }
            .font(.system(size: 18))
            
            Spacer()
        }
    }
}

struct ProcessCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCompletedView()
    }
}
