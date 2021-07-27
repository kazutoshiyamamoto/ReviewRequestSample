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
                                
                                // 低評価を選択した場合はアプリのストアレビュー候補から外す
                                if ratingNumber == 1 || ratingNumber == 2 {
                                    StoreReviewHelper.shared.removeFromTarget()
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
            StoreReviewHelper.shared.updateProcessCompletedCount()
        })
    }
}

struct ProcessCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCompletedView()
    }
}
