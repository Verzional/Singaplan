//
//  RecommendedDistricts.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct RecommendedDistrictView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(FlowManager.self) private var flowManager
    
    @State private var topDistricts: [District] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if topDistricts.isEmpty {
                    ProgressView("Analyzing recommendations...")
                } else {
                    ForEach(topDistricts) { district in
                        RecommendedCard(district: district, onAdd: {
                            guard let targetDay = flowManager.targetDay else { return }
                            
                            let service = ItineraryService(modelContext: modelContext)
                            
                            service.addDistrict(district, to: targetDay)
                        })
                        .onTapGesture {
                            // Action: Navigate to RecommendedPOIView for this district
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Top Districts")
        .onAppear {
            calculateRecommendations()
        }
    }
    
    private func calculateRecommendations() {
        guard let categoryPreset = flowManager.selectedCategoryPreset,
              let priorityPreset = flowManager.selectedPriorityPreset else {
            print("Missing presets in flow manager!")
            return
        }
        
        let service = ItineraryService(modelContext: modelContext)
        
        topDistricts = service.getTopRecommendedDistricts(
            categoryPreset: categoryPreset,
            priorityPreset: priorityPreset
        )
    }
}


//#Preview {
//    RecommendedDistrictView()
//}
