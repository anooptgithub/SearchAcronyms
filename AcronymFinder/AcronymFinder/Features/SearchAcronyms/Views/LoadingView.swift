//
//  LoadingView.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import SwiftUI

// This View represents loading state when user is searching
struct LoadingView: View {
    var body: some View {
        VStack(alignment: .center) {
            ProgressView("Searching")
                .progressViewStyle(.automatic)
                .font(.callout)
        }
    }
}

// Preview for LoadingView
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

