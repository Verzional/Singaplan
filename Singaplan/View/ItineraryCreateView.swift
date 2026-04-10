//
//  ItineraryCreate.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData

struct ItineraryCreateView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \ItineraryFolder.folderName) private var allFolders: [ItineraryFolder]
    
    // MARK: State Variables
    @State private var showModal = false
    @State private var folderNameInput = ""
    @State private var dayCountInput = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                
                // MARK: Header
                HStack {
                    Text("Itinerary")
                        .font(.system(size: 32))
                        .bold()
                    
                    Spacer()
                    
                    if !allFolders.isEmpty {
                        Button(action: {
                            prepareNewInput()
                            showModal = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 30))
                                .foregroundStyle(Color.black, Color.gray.opacity(0.2))
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 15)
                
                // MARK: Content View
                // MARK: Content View
                if allFolders.isEmpty {
                    emptyStateCard
                } else {
                    List {
                        ForEach(allFolders) { folder in
                            ZStack {
                                ItineraryFolderListView(
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
                                    deleteFolder(folder)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            // MARK: - Modal Input
            .sheet(isPresented: $showModal) {
                ItineraryInputModalView(
                    folderName: $folderNameInput,
                    day: $dayCountInput,
                    onCancel: { showModal = false },
                    onSave: {
                        saveNewItinerary()
                        showModal = false
                    }
                )
            }
        }
    }
}

// MARK: Extension
private extension ItineraryCreateView {
    
    // func: delete folder
    func deleteFolder(_ folder: ItineraryFolder) {
        withAnimation(.spring()) {
            modelContext.delete(folder)
                
            if let _ = try? modelContext.save() {
                print("Folder \(folder.folderName) berhasil dihapus")
            }
        }
    }
    
    // Tampilan Kartu Tambah Pertama (Empty State)
    var emptyStateCard: some View {
        VStack {
            Circle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 35, height: 35)
                .overlay(Text("+").font(.title))
                .foregroundColor(.white)
            
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
            prepareNewInput()
            showModal = true
        }
    }
    
    func prepareNewInput() {
        folderNameInput = ""
        dayCountInput = ""
    }

    // Func utama menyimpan ke SwiftData
    func saveNewItinerary() {
        guard !folderNameInput.isEmpty, let totalDays = Int(dayCountInput) else { return }
        
        // Buat Parent (Folder)
        let newFolder = ItineraryFolder(folderName: folderNameInput)
        modelContext.insert(newFolder)
        
        // Buat Anak-anaknya (Days)
        for i in 1...totalDays {
            let newDay = ItineraryDay(dayNumber: i)
            newDay.itineraryFolder = newFolder // Link relasi ke folder
            modelContext.insert(newDay)
        }
        
        // 3. Simpan
        do {
            try modelContext.save()
        } catch {
            print("Gagal menyimpan data: \(error.localizedDescription)")
        }
    }
}

// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ItineraryFolder.self, ItineraryDay.self, POI.self, configurations: config)
    
    return ItineraryCreateView()
        .modelContainer(container)
}
