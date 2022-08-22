//
//  SearchEmptyStateView.swift
//  AcronymFinder
//
//  Created by Anoop Thomas on 8/21/22.
//

import SwiftUI

extension EmptyStateView {
    enum State {
        case beginSearch
        case noResultsFound
    }
}

// This view handles the empty states. Handles the followinig states:
//      1. Begin Search
//      2. When No Results are found
struct EmptyStateView: View {
    
    let state: State
    
    var body: some View {
        VStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .fixedSize()
                .padding(.bottom, 15)
            Text(title)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .font(.subheadline)
                .padding(.bottom, 1)
            Text(subTitle)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .font(.footnote)
        }
    }
    
    var imageName: String {
        switch state {
        case .beginSearch:
            return "beginSearch"
        case .noResultsFound:
            return "no_result"
        }
    }
    
    var title: String {
        switch state {
        case .beginSearch:
            return "Start your search!"
        case .noResultsFound:
            return "No results!"
        }
    }
    
    var subTitle: String {
        switch state {
        case .beginSearch:
            return "Find meaning of Acronyms or Initialisms you don't know yet"
        case .noResultsFound:
            return "Try searching for another acronym or initialism."
        }
    }
}

// Preview for EmptyStateView
struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 100) {
            EmptyStateView(state: .beginSearch)
            EmptyStateView(state: .noResultsFound)
        }
    }
}
