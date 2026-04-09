//
//  ItineraryDetails.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

enum ItineraryViewMode {
    case grid
    case list
}

struct ItineraryDetails: View {
    // MARK: - SwiftData Context
    @Environment(\.modelContext) private var modelContext
    
    // data diurutkan berdasarkan nomor harinya
    @Query(sort: \ItineraryDay.dayNumber) private var itineraryList: [ItineraryDay]
    
    // MARK: State Variables
    @State private var viewMode: ItineraryViewMode = .grid
    @State private var expandedDays: Set<UUID> = []
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            List {
                // Looping ehe
                ForEach(itineraryList) { day in
                    itineraryRow(day)
                }
                
                addDayButton
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Itinerary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
        }
    }
}

// MARK: Extension
private extension ItineraryDetails {
    
    // func memunculkan places yang sudah disave
    func itineraryRow(_ day: ItineraryDay) -> some View {
        DaySection(
            day: day,
            viewMode: viewMode,
            expandedDays: $expandedDays
        )
        .listRowSeparator(.hidden)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                deleteDay(day)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    // add Day button
    var addDayButton: some View {
        Button(action: addDay) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Add Day")
            }
            .fontWeight(.medium)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .buttonStyle(.plain)
        .foregroundColor(.blue)
    }
    
    // toolbar
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Picker("View Mode", selection: $viewMode) {
                Image(systemName: "square.grid.2x2").tag(ItineraryViewMode.grid)
                Image(systemName: "list.bullet").tag(ItineraryViewMode.list)
            }
            .pickerStyle(.segmented)
            .frame(width: 100)
        }
    }
}

private extension ItineraryDetails {
    
    // func logic untuk menambahkan day
    func addDay() {
        withAnimation(.spring()) {
            let nextNumber = (itineraryList.last?.dayNumber ?? 0) + 1
            let newDay = ItineraryDay(dayNumber: nextNumber)
            modelContext.insert(newDay)
        }
    }
    
    // func logic untuk menghapus day
    func deleteDay(_ day: ItineraryDay) {
        withAnimation {
            modelContext.delete(day)
        }
    }
}

// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for:
        ItineraryDay.self,
        POI.self,
        District.self,
        CategoryModel.self,
        Photo.self,
        configurations: config
    )
    
    let context = container.mainContext
    
    let natureCategory = CategoryModel(title: "Nature & Outdoors", icon: "leaf.fill")
    let forestSub = CategoryModel(title: "Forest", icon: "tree.fill", parent: natureCategory)
    let marinaSouth = District(id: "d1", name: "Marina South", address: "Central", desc: "Modern area", photoUrl: "marina-bg")
    let chinatown = District(id: "d2", name: "Chinatown", address: "Chinatown", desc: "Old Chinatown", photoUrl: "chinatown-bg")
    let orchard = District(id: "d3", name: "Orchard", address: "Orchard", desc: "Downtown Orchard", photoUrl: "orchard-bg")
    
    
    let day1 = ItineraryDay(dayNumber: 1)
    let day2 = ItineraryDay(dayNumber: 2)
    
    let gardens = POI(
        id: "poi-1",
        name: "Gardens by the Bay",
        desc: "Cloud Forest and Supertrees",
        location: "18 Marina Gardens Dr",
        district: marinaSouth,
        subcategory: forestSub,
        photo: Photo(id: "p1", url: "buddha-tooth-relic-temple.png")
    )
    
    day1.plannedDistricts.append(chinatown)
    day1.plannedDistricts.append(orchard)
    day2.plannedDistricts.append(orchard)
    
    gardens.itineraryDay = day1
    context.insert(day1)
    context.insert(day2)
    
    return ItineraryDetails()
        .modelContainer(container)
}

