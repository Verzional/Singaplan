//
//  DaySection.swift
//  Singaplan
//
//  Created by Sherin Alvinia Yonatan on 07/04/26.
//

import SwiftData
import SwiftUI

struct DaySection: View {
    @Environment(FlowManager.self) private var flowManager
    // Variable
    let day: ItineraryDay
    let viewMode: ItineraryViewMode
    @Binding var expandedDays: Set<UUID>
    
    @Query private var allDistricts: [District]
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            headerView
            
            if isExpanded {
                contentView
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: Extension
extension DaySection {
    
    // Memunculkan day
    private var headerView: some View {
        HStack {
            HStack(spacing: 8) {
                Text("Day \(day.dayNumber)")
                    .font(.headline)
                
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                toggleExpand()
            }
            
            Spacer()
            
            addDestinationMenu
        }
    }
    
    // Memunculkan data konten yang telah disave/belum
    @ViewBuilder
    private var contentView: some View {
        if day.destinations.isEmpty && availableDistricts.isEmpty {
            emptyStateView
        } else {
            destinationLayout
        }
    }
    
    // Mode Grid atau List
    private var destinationLayout: some View {
        Group {
            if viewMode == .grid {
                horizontalScrollView
            } else {
                verticalGridView
            }
        }
    }
    
    // Mode List
    private var horizontalScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(day.destinations) { poi in
                    DestinationCard(poi: poi)
                        .frame(width: 140, height: 140)
                }
                
                ForEach(availableDistricts) { district in
                    DistrictCard(district: district)
                        .frame(width: 140, height: 140)
                }
            }
        }
    }
    
    // mode Grid
    private var verticalGridView: some View {
        let columns = [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12),
        ]
        
        return LazyVGrid(columns: columns, spacing: 12) {
            ForEach(day.destinations) { poi in
                DestinationCard(poi: poi)
                    .frame(height: 160)
            }
            
            ForEach(availableDistricts) { district in
                DistrictCard(district: district)
                    .frame(height: 160)
            }
        }
    }
    
    // Pull down button
    private var addDestinationMenu: some View {
        Menu {
            NavigationLink {
                CategoryPresetView()
                    .onAppear {
                        flowManager.targetDay = day
                    }
            } label: {
                Label("Discover", systemImage: "globe")
                    .foregroundStyle(Color.primary)
            }
            
            NavigationLink {
                ManualSearchView(targetDay: day)
            } label: {
                Label("Search", systemImage: "magnifyingglass")
                    .foregroundStyle(Color.primary)
            }
        } label: {
            Image(systemName: "plus")
                .font(.title3)
                .foregroundColor(.primary)
        }
    }
    
    // Kalau data kosong
    private var emptyStateView: some View {
        Text("No destinations added yet.")
            .font(.subheadline)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 4)
    }
    
    // untuk memunculkan jika ada district, tapi belum pilih poi
    fileprivate var availableDistricts: [District] {
        let occupiedDistrictIds = Set(day.destinations.compactMap { $0.district?.id })
        return day.plannedDistricts.filter { !occupiedDistrictIds.contains($0.id) }
    }
    
    // bool untuk apakah akan dropdown atau tidak
    fileprivate var isExpanded: Bool {
        expandedDays.contains(day.id)
    }
    // func dropdown
    fileprivate func toggleExpand() {
        if isExpanded {
            expandedDays.remove(day.id)
        } else {
            expandedDays.insert(day.id)
        }
    }
}

// MARK: Preview
//#Preview {
//    // 1. Create a schema and container
//    let schema = Schema([ItineraryDay.self, POI.self, District.self])
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: schema, configurations: [config])
//
//    // 2. Setup sample data
//    let marina = District(
//        name: "Marina South", address: "", desc: "", photoUrls: ["singapore", "marina-bg"])
//    let day = ItineraryDay(dayNumber: 1)
//    let gardens = POI(
//        id: "p1", name: "Gardens by the Bay", desc: "", address: "", district: marina)
//    gardens.itineraryDay = day
//
//    // 3. Add to container
//    container.mainContext.insert(day)
//
//    DaySection(
//        day: day,
//        viewMode: .grid,
//        expandedDays: .constant([day.id])
//    )
//    .modelContainer(container)  // CRITICAL: This must be active if @Query is used
//    .padding()
//}
