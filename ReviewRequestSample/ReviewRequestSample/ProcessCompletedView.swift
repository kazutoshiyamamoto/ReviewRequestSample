//
//  ProcessCompletedView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI

struct ProcessCompletedView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Process Completed")
                .font(.system(size: 24))
                .padding()
            
            Button("Start Over") {
                presentationMode.wrappedValue.dismiss()
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
