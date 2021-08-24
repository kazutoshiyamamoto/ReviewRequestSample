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
    private var rankTexts = ["", "Bad", "", "", "", "Good", ""]
    
    @State private var isPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
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
                                        
                                        // 低評価を選択した場合はアプリのストアレビュー依頼対象から外す
                                        if ratingNumber <= 2 {
                                            StoreReviewHelper.shared.removeFromCandidate()
                                        }
                                        
                                        // ポップアップ表示（非表示は自動で行う）
                                        withAnimation(.easeOut(duration: 1.0)) {
                                            isPresented = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                            withAnimation(.easeIn(duration: 1.0)) {
                                                isPresented = false
                                            }
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
                }
                
                if isPresented {
                    OverlayView(isPresented: $isPresented)
                        .position(x: geometry.size.width / 2, y: -70)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear(perform: {
                StoreReviewHelper.shared.updateProcessCompletedCount()
            })
        }
    }
}

struct OverlayView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Text("Submitted!")
            .font(.subheadline)
            .frame(width: 220, height: 50)
            .background(Color.white)
            .cornerRadius(100)
            .shadow(color: Color(red: 0.85, green: 0.85, blue: 0.85), radius: 20)
            .transition(.move(edge: .top))
    }
}

struct ProcessCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCompletedView()
    }
}
