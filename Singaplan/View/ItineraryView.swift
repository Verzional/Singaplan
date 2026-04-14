//
//  ItineraryView.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftData
import SwiftUI

struct ItineraryView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Itinerary.folderName) private var allFolders: [Itinerary]
    
    @State private var showModal = false
    @State private var folderNameInput = ""
    @State private var dayCountInput = 1
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                headerSection
                cardList
            }
            .padding(.horizontal)
            .sheet(isPresented: $showModal) {
                ItineraryCreateView(
                    folderName: $folderNameInput,
                    day: $dayCountInput,
                    onCancel: {
                        showModal = false
                    },
                    onSave: {
                        saveNewItinerary()
                    }
                )
            }
        }
    }
}

// MARK: - View Functions
extension ItineraryView {
    fileprivate func prepareNewInput() {
        folderNameInput = ""
        dayCountInput = 1
    }
    
    fileprivate func saveNewItinerary() {
        guard !folderNameInput.isEmpty, dayCountInput > 0 else { return }
        
        let newFolder = Itinerary(folderName: folderNameInput)
        modelContext.insert(newFolder)
        
        for i in 1...dayCountInput {
            let newDay = ItineraryDay(dayNumber: i)
            newDay.itineraryFolder = newFolder
            modelContext.insert(newDay)
        }
        
        try? modelContext.save()
        showModal = false
    }
    
    fileprivate func deleteFolder(_ folder: Itinerary) {
        modelContext.delete(folder)
        try? modelContext.save()
    }
}

// MARK: - View Components
extension ItineraryView {
    fileprivate var headerSection: some View {
        HStack {
            Text("Itinerary")
                .font(.system(size: 34))
                .fontWeight(.bold)
            
            Spacer()
            
            addButton
        }
    }
    
    fileprivate var addButton: some View {
        Button(action: {
            prepareNewInput()
            showModal = true
        }) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(.black)
                .padding(10)
                .background {
                    Circle()
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
        }
    }
    
    fileprivate var emptyStateCard: some View {
        VStack(spacing: 8) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(.black)
                .padding(10)
                .background {
                    Circle()
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
            
            Text("Make your trip happen")
                .font(.headline)
                .foregroundColor(.black)
            
            Text("Add your first itinerary")
                .font(.caption)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 5)
        .onTapGesture {
            prepareNewInput()
            showModal = true
        }
    }
    
    @ViewBuilder
    fileprivate var cardList: some View {
        if allFolders.isEmpty {
            ContentUnavailableView(
                "No Itineraries",
                systemImage: "tray",
                description: Text("Tap + to create a new itinerary.")
            )
        } else {
            List {
                ForEach(allFolders) { folder in
                    ZStack {
                        ItineraryFolder(
                            folderName: folder.folderName,
                            days: "\(folder.days.count)",
                            backgroundImageName: "singapore",
                            onBack: {}
                        )
                        NavigationLink(destination: ItineraryDetailView(folder: folder)) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            deleteFolder(folder)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

// MARK: - Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Itinerary.self, ItineraryDay.self, POI.self, configurations: config)
    
    let context = container.mainContext
    let dummyItinerary = Itinerary(folderName: "Bali Trip")
    context.insert(dummyItinerary)
    
    return ItineraryView()
        .modelContainer(container)
}
