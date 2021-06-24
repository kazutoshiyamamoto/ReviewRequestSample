//
//  ContentView.swift
//  ReviewRequestSample
//
//  Created by home on 2021/06/14.
//

import SwiftUI

struct InitialView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: ProcessCompletedView()) {
                Text("Start Process")
                    .font(.system(size: 24))
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
