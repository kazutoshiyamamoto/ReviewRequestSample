//
//  ProcessCompletedView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI

struct ProcessCompletedView: View {
    var body: some View {
            Text("Process Completed")
                .font(.system(size: 24))
                .padding()
        .navigationTitle("Completed View")
    }
}

struct ProcessCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessCompletedView()
    }
}
