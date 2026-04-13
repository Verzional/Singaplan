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

struct ItineraryDetailView: View {
    // MARK: Model
    @Environment(\.modelContext) private var modelContext
    
    var folder: Itinerary
    
    // MARK: State Variables
    @State private var viewMode: ItineraryViewMode = .grid
    @State private var expandedDays: Set<UUID> = []
    @State private var flowManager = FlowManager()
    
    // filter: Ambil hari miliki folder ini
    var filteredDays: [ItineraryDay] {
        folder.days.sorted { $0.dayNumber < $1.dayNumber }
    }
    
    // MARK: Body
    var body: some View {
        List {
            ForEach(filteredDays) { day in
                itineraryRow(day)
            }
            
            addDayButton
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle(folder.folderName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            toolbarContent
        }
        .environment(flowManager)
        
    }
}

// MARK: Extension
private extension ItineraryDetailView {
    
    // func: memunculkan row
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
                Image(systemName: "trash")
            }
        }
    }
    
    // Buat Button Add Day
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
    
    // Toolbar
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
    
    func addDay() {
        withAnimation() {
            let nextNumber = (filteredDays.last?.dayNumber ?? 0) + 1
            let newDay = ItineraryDay(dayNumber: nextNumber)
            newDay.itineraryFolder = folder
            modelContext.insert(newDay)
        }
    }
    
    func deleteDay(_ day: ItineraryDay) {
        if folder.days.contains(day) {
            withAnimation {
                modelContext.delete(day)
                
                let remainingDays = folder.days.sorted { $0.dayNumber < $1.dayNumber }
                for (index, item) in remainingDays.enumerated() {
                    item.dayNumber = index + 1
                }
                
                if let _ = try? modelContext.save() {
                    print("Simpan berhasil")
                } else {
                    print("Simpan gagal")
                }
            }
        }
    }
}

// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Itinerary.self, ItineraryDay.self, POI.self, District.self, Category.self, Photo.self, configurations: config)
    
    let context = container.mainContext
    let previewFolder = Itinerary(folderName: "Girls Trip Preview")
    context.insert(previewFolder)
    
    let day1 = ItineraryDay(dayNumber: 1)
    day1.itineraryFolder = previewFolder
    context.insert(day1)
    
    return NavigationStack {
        ItineraryDetailView(folder: previewFolder)
            .modelContainer(container)
    }
}
