//
//  DaySection.swift
//  Singaplan
//
//  Created by Sherin Alvinia Yonatan on 07/04/26.
//

import SwiftUI
import SwiftData

struct DaySection: View {
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
private extension DaySection {
    
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
            GridItem(.flexible(), spacing: 12)
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
            Button { /* Action */ } label: {
                Label("Discover", systemImage: "globe")
            }
            Button { /* Action */ } label: {
                Label("Search", systemImage: "magnifyingglass")
            }
        } label: {
            Image(systemName: "plus")
                .font(.title3)
                .foregroundColor(.black)
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
    var availableDistricts: [District] {
        let occupiedDistrictIds = Set(day.destinations.compactMap { $0.district?.id })
            return day.plannedDistricts.filter { !occupiedDistrictIds.contains($0.id) }
        }
    
    // bool untuk apakah akan dropdown atau tidak
    var isExpanded: Bool {
        expandedDays.contains(day.id)
    }
    // func dropdown
    func toggleExpand() {
        if isExpanded {
            expandedDays.remove(day.id)
        } else {
            expandedDays.insert(day.id)
        }
    }
}

// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ItineraryDay.self, POI.self, District.self, Photo.self, configurations: config)
    let context = container.mainContext
        
    let marina = District(id: "d1", name: "Marina South", address: "", desc: "", photoUrl: "marina-bg")
    let chinatown = District(id: "d2", name: "Chinatown", address: "", desc: "", photoUrl: "marina-bg")
    context.insert(marina)
    context.insert(chinatown)
            
    let day = ItineraryDay(dayNumber: 1)
        
    day.plannedDistricts.append(chinatown)
        
    let gardens = POI(id: "p1", name: "Gardens by the Bay", desc: "", location: "", district: marina)
    gardens.itineraryDay = day
            
    context.insert(day)
    context.insert(gardens)
            
    return DaySection(
        day: day,
        viewMode: .grid,
        expandedDays: .constant([day.id])
        )
        .modelContainer(container)
}
