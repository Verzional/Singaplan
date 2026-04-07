//
//  ManualSearch.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI

struct ManualSearch: View {
    @State private var searchText = ""
        var body: some View {
        VStack(spacing: 0) { 
            if searchText.isEmpty {
                spotlightImageSection
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            searchBarSection
            
            if searchText.isEmpty {
                recentSearchesList
                    .transition(.opacity)
            } else {
                searchResultsSection
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            Spacer()
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: searchText.isEmpty)
    }
}

extension ManualSearch {
    
    private var spotlightImageSection: some View {
        Image("universal_studios")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .clipShape(
                UnevenRoundedRectangle(topLeadingRadius: 40, topTrailingRadius: 40)
            )
    }
    
    /// Integration of the friend's SearchBar component
    private var searchBarSection: some View {
        SearchBar(text: $searchText, placeholder: "Search")
            .padding(.vertical, 15)
    }

    private var recentSearchesList: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Recent Searches").font(.headline)
                Spacer()
                Button("Clear All") {}.font(.subheadline).foregroundColor(.gray)
            }
            
            let recentSearches = ["Garden by the Bay", "Singapore Zoo", "Chinatown", "Universal Studios"]
            ForEach(recentSearches, id: \.self) { item in
                Text(item)
                    .font(.body)
                    .padding(.vertical, 5)
            }
        }
        .padding(.horizontal, 25)
        .padding(.top, 10)
    }
    
    private var searchResultsSection: some View {
        Text("Results for \(searchText)")
            .padding()
    }
}

#Preview {
    ManualSearch()
}
