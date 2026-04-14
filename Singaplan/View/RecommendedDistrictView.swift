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
    @State private var selectedDistrict: District?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if topDistricts.isEmpty {
                    ProgressView("Analyzing recommendations...")
                } else {
                    ForEach(topDistricts) { district in
                        RecommendedCard(district: district, isSelected: selectedDistrict?.id == district.id, onAdd: {
                            print("onAdd tapped for district:", district.name)
                            guard let targetDay = flowManager.targetDay else {
                                print("No targetDay set in FlowManager")
                                return
                            }

                            let service = ItineraryService(modelContext: modelContext)
                            service.addDistrict(district, to: targetDay)
                        })
                        .onTapGesture {
                            selectedDistrict = district
                            flowManager.selectedDistrict = district
                        }
                    }
                }
                
                Spacer()
                
                continueButton
            }
            .padding()
        }
        .navigationTitle("Top Districts")
        .onAppear {
            calculateRecommendations()
        }
    }
}

// MARK: - View Components
extension RecommendedDistrictView {
    fileprivate var continueButton: some View {
        NavigationLink {
            RecommendedPOIView()
        } label: {
            Text("Continue")
        }
        .buttonStyle(.borderedProminent)
        .disabled(selectedDistrict == nil)
    }
}

// MARK: - View Functions
extension RecommendedDistrictView {
    fileprivate func calculateRecommendations() {
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

// MARK: - Preview
#Preview("Recommended Districts") {
    // 1) In-memory SwiftData container
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Category.self,
        CategoryPreset.self,
        District.self,
        ItineraryDay.self,
        Itinerary.self,
        POI.self,
        Priority.self,
        PriorityPreset.self,
        configurations: config
    )

    // 2) Seed minimal data needed for recommendations
    let context = container.mainContext

    // Categories
    let categories: [Category] = [
        Category(title: "Nature", icon: "leaf.fill"),
        Category(title: "Scenic", icon: "camera.fill"),
        Category(title: "Family", icon: "figure.2.and.child.holdinghands")
    ]
    categories.forEach { context.insert($0) }

    // Priorities (very small set)
    let priorities: [Priority] = [
        Priority(
            title: "Budget",
            desc: "Overall cost",
            segments: [
                PrioritySegment(label: "$", weight: 0.1),
                PrioritySegment(label: "$$", weight: 0.5),
                PrioritySegment(label: "$$$", weight: 1.0)
            ]
        ),
        Priority(
            title: "Popularity",
            desc: "How popular it is",
            segments: [
                PrioritySegment(label: "Low", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "High", weight: 1.0)
            ]
        )
    ]
    priorities.forEach { context.insert($0) }

    // Districts
    let districts: [District] = [
        District(
            name: "Marina Bay",
            address: "Marina Bay, Singapore",
            desc: "Iconic skyline and waterfront promenade.",
            photoUrls: ["marina_bay"],
            priorities: priorities,
            categories: categories
        ),
        District(
            name: "Sentosa",
            address: "Sentosa Gateway, Singapore",
            desc: "Beaches and attractions on a resort island.",
            photoUrls: ["sentosa"],
            priorities: priorities,
            categories: categories
        ),
        District(
            name: "Punggol",
            address: "Punggol, Singapore",
            desc: "Parks and waterfront living.",
            photoUrls: ["punggol"],
            priorities: priorities,
            categories: categories
        )
    ]
    districts.forEach { context.insert($0) }

    // 3) Create presets used by the view’s recommendation logic
    let categoryPreset = CategoryPreset(
        title: "Explorer",
        desc: "Nature and scenic focused.",
        categories: categories
    )
    context.insert(categoryPreset)

    let priorityPreset = PriorityPreset(
        title: "Balanced",
        desc: "Good for most travelers.",
        priorities: priorities
    )
    context.insert(priorityPreset)

    // 4) Create a day and set it as targetDay
    let day = ItineraryDay(dayNumber: 1)
    context.insert(day)

    // 5) Configure FlowManager environment
    let flow = FlowManager()
    flow.selectedCategoryPreset = categoryPreset
    flow.selectedPriorityPreset = priorityPreset
    flow.targetDay = day

    // 6) Compose the preview
    return NavigationStack {
        RecommendedDistrictView()
            .navigationTitle("Top Districts")
    }
    .modelContainer(container)
    .environment(flow)
}
