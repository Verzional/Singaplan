import SwiftUI

//MARK: Body
struct ManualSearch: View {
    @State private var searchText = ""
        //help to search filtered
        var filteredResults: [Place] {
            if searchText.isEmpty {
                return []
            } else {
                return Place.Places.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
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
        .edgesIgnoringSafeArea(.top)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: searchText.isEmpty)
    }
}

extension ManualSearch {
    //MARK: Spotlight Image
    /// Main image above the SearchBar
    private var spotlightImageSection: some View {
            Image("universal_studios")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 240)
                .clipped()
    }
    //MARK: Search Bar
    /// SearchBar that follows the modal placement
    private var searchBarSection: some View {
        SearchBar(text: $searchText, placeholder: "Search")
            .padding(.vertical, 20)
    }
    //MARK: Recent Searches
    /// Places recently searched by users
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
    //MARK: Search Result
    /// Card results for places
    private var searchResultsSection: some View {
        VStack(spacing: 16) {
                    if filteredResults.isEmpty {
                        Text("No results for \"\(searchText)\"")
                            .foregroundColor(.secondary)
                            .padding(.top, 40)
                    } else {
                        ForEach(filteredResults) { place in
                            RecommendedCard(place: place)
                        }
                    }
                }
            .padding()
    }
}

//MARK: Mock Data Show
struct Place: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
    let tags: [String]
}

extension Place {
    static let Places: [Place] = [
        Place(name: "Chinatown",
              imageName: "chinatown_img",
              description: "Chinatown is a vibrant historic district blending traditional Chinese heritage...",
              tags: ["Historical", "Foodies"]),
        Place(name: "Garden by the Bay",
              imageName: "gardens_img",
              description: "A showpiece of horticulture and garden artistry.",
              tags: ["Nature", "Scenic"]),
        Place(name: "Universal Studios",
              imageName: "universal_studios",
              description: "Experience cutting-edge rides, shows, and attractions.",
              tags: ["Family", "Fun"])
    ]
}

//MARK: Preview
#Preview {
    ManualSearch()
}
