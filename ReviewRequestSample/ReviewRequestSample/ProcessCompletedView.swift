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
            .padding([.bottom], 20)
            
            if let linkURL = URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review") {
                Link("Link", destination: linkURL)
                    .font(.system(size: 18))
                    .padding([.bottom], 20)
            }
            
            Button("Start Over") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.system(size: 18))
            
            Spacer()
        }
        .onAppear(perform: {
            var count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCountKey)
            count += 1
            UserDefaults.standard.set(count, forKey: UserDefaultsKeys.processCompletedCountKey)
            print("Process completed \(count) time(s)")
        })
    }
}

struct ProcessCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCompletedView()
    }
}
