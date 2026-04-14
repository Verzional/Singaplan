//
//  RecommendedPOIView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 13/04/26.
//

import SwiftUI
import SwiftData

struct RecommendedPOIView: View {
    // MARK: - File Properties
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(FlowManager.self) private var flowManager
    
    @State private var topPOIs: [POI] = []
    @State private var selectedPOI: POI?
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if topPOIs.isEmpty {
                    ProgressView("Finding the best spots...")
                        .padding(.top, 40)
                } else {
                    ForEach(topPOIs) { poi in
                        RecommendedCard(
                            poi: poi,
                            onAdd: {
                                guard let targetDay = flowManager.targetDay else { return }
                                let service = ItineraryService(modelContext: modelContext)
                                service.addPOI(poi, to: targetDay)
                            },
                            onInfoTapped: {
                                selectedPOI = poi
                            }
                        )
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Top POIs")
        .onAppear {
            calculatePOIs()
        }
        .toolbar {
            navigationToolbar
        }
        .sheet(item: $selectedPOI) { poiToShow in
            TravelPointDetailView(poi: poiToShow)
        }
    }
}

// MARK: - View Components
extension RecommendedPOIView {
    fileprivate var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button {
                flowManager.reset()
                flowManager.popToItineraryDetail()
            } label: {
                Image(systemName: "checkmark")
            }
        }
    }
}

// MARK: - View Functions
extension RecommendedPOIView {
    fileprivate func calculatePOIs() {
        guard let categoryPreset = flowManager.selectedCategoryPreset,
              let priorityPreset = flowManager.selectedPriorityPreset,
              let district = flowManager.selectedDistrict else {
            print("Missing data in flow manager!")
            return
        }
        
        let service = ItineraryService(modelContext: modelContext)
        topPOIs = service.getTopRecommendedPOIs(
            for: district,
            categoryPreset: categoryPreset,
            priorityPreset: priorityPreset
        )
    }
}
