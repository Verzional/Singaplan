//
//  ItineraryCreate.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct ItineraryView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = ItineraryViewModel()
    
    @Query(sort: \Itinerary.folderName) private var allFolders: [Itinerary]
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                headerSection
                
                // MARK: Content View
                if allFolders.isEmpty {
                    emptyStateCard
                } else {
                    cardList
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            // MARK: Modal Input
            .sheet(isPresented: $viewModel.showModal) {
                ItineraryCreateView(
                    folderName: $viewModel.folderNameInput,
                    day: $viewModel.dayCountInput,
                    onCancel: {
                        viewModel.showModal = false
                    },
                    onSave: {
                        viewModel.saveNewItinerary()
                    }
                )
            }
        }
        .onAppear {
            viewModel.modelContext = modelContext
        }
    }
}

// MARK: - Extension
private extension ItineraryView {
    var headerSection: some View {
        HStack {
            Text("Itinerary")
                .font(.system(size: 34))
                .fontWeight(.bold)
            
            Spacer ()
            
            if !allFolders.isEmpty {
                addButton
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            viewModel.prepareNewInput()
            viewModel.showModal = true
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
    
    // Tampilan Kartu Tambah Pertama (Empty State)
    var emptyStateCard: some View {
        VStack(spacing: 8){
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
            viewModel.prepareNewInput()
            viewModel.showModal = true
        }
    }
    
    var cardList: some View {
        List {
            ForEach(allFolders) { folder in
                ZStack {
                    ItineraryFolder(
                        folderName: folder.folderName,
                        days: "\(folder.days.count)",
                        onBack: { }
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
                        viewModel.deleteFolder(folder)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Itinerary.self, ItineraryDay.self, POI.self, configurations: config)
    let context = container.mainContext
    
    //    let dummyItinerary = Itinerary(folderName: "Bali Trip")
    //    
    //    context.insert(dummyItinerary)
    
    return ItineraryView()
        .modelContainer(container)
}
