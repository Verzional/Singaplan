//
//  ManualSearch.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI

struct ManualSearch: View {
    @State private var searchText = ""
    
    let recentSearches = ["Garden by the Bay", "Singapore Zoo", "Chinatown", "Universal Studios"]

    var body: some View {
        VStack(spacing: 20) {
            //Header
            Image("universal_studios")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 40,
                        topTrailingRadius: 40,
                        style: .continuous
                    )
                )

            //Search
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchText)
                Image(systemName: "mic.fill")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(30)
            .padding(.horizontal)

            //Recents
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Recent Searchers")
                        .font(.headline)
                    Spacer()
                    Button("Clear All") { }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                ForEach(recentSearches, id: \.self) { item in
                    Text(item)
                        .font(.body)
                        .padding(.vertical, 5)
                }
            }
            .padding(.horizontal, 25)

            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    ManualSearch()
}
