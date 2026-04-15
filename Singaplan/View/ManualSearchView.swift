import SwiftUI
import SwiftData

struct ManualSearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText = ""
    var targetDay: ItineraryDay?
    
    @Query private var allDistricts: [District]
    @Query private var allPOIs: [POI]
    
    // 1. Track the selected result for the detail sheet
    @State private var selectedResult: SearchResult?
    
    // Combine and filter results
    var filteredResults: [SearchResult] {
        if searchText.isEmpty { return [] }
        
        let lowerSearch = searchText.localizedLowercase
        
        let matchingDistricts = allDistricts
            .filter { $0.name.localizedLowercase.contains(lowerSearch) }
            .map { SearchResult.district($0) }
        
        let matchingPOIs = allPOIs
            .filter { $0.name.localizedLowercase.contains(lowerSearch) }
            .map { SearchResult.poi($0) }
        
        return matchingDistricts + matchingPOIs
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if searchText.isEmpty {
                spotlightImageSection
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            
            if searchText.isEmpty {
                recentSearchesList
                    .transition(.opacity)
            } else {
                searchResultsSection
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.top, 76)
            }
            
            Spacer()
            
            searchBarSection
        }
        .edgesIgnoringSafeArea(.top)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: searchText.isEmpty)
        // 2. Attach the sheet modifier using the selected item
        .sheet(item: $selectedResult) { resultToShow in
            switch resultToShow {
            case .district(let district):
                TravelPointDetailView(district: district)
            case .poi(let poi):
                TravelPointDetailView(poi: poi)
            }
        }
    }
}

extension ManualSearchView {
    private var spotlightImageSection: some View {
        Image("universal_studios")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 240)
            .clipped()
    }
    
    private var searchBarSection: some View {
        SearchBar(text: $searchText, placeholder: "Search Districts & POIs")
            .padding(.vertical, 20)
    }
    
    private var recentSearchesList: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Recent Searches").font(.headline)
                Spacer()
                Button("Clear All") {}.font(.subheadline).foregroundColor(.gray)
            }
            
            // This can be hooked up to a real history later
            let recentSearches = ["Garden by the Bay", "Singapore Zoo", "Chinatown"]
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
        ScrollView {
            VStack(spacing: 16) {
                if filteredResults.isEmpty {
                    Text("No results found for \"\(searchText)\"")
                        .foregroundColor(.secondary)
                        .padding(.top, 40)
                } else {
                    ForEach(filteredResults) { result in
                        RecommendedCard(
                            result: result,
                            onAdd: {
                                guard let targetDay = targetDay else { return }
                                
                                let service = ItineraryService(modelContext: modelContext)
                                
                                switch result {
                                case .district(let district):
                                    service.addDistrict(district, to: targetDay)
                                case .poi(let poi):
                                    service.addPOI(poi, to: targetDay)
                                }
                                
                                dismiss()
                            },
                            // 3. Set the state variable when the info button is tapped
                            onInfoTapped: {
                                selectedResult = result
                            }
                        )
                    }
                }
            }
            .padding()
        }
    }
}
