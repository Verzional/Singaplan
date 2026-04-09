//
//  ItineraryCreate.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
struct ItineraryCreate: View {
// MARK: - Properties
    @State private var showModal = false
    @State private var isSaved = false
    @State private var folderName = "Girls Trip"
    @State private var day = "4"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
// MARK: - Header
            HStack {
                Text("Itinerary")
                    .font(.system(size: 32))
                    .bold()
                
                Spacer()
                
                if isSaved {
                    Button(action: { showModal = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(Color.black, Color.gray.opacity(0.2))
                    }
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 15)
            
// MARK: - Content View
            if isSaved {
                ItineraryFolderList(
                    folderName: folderName,
                    days: day,
                    onBack: {
                        isSaved = false }
                )
            } else {
                
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
                .frame(width: 334, height: 85)
                .frame(height: 100)
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 5)
                .onTapGesture {
                    showModal = true
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        
// MARK: - Modal
        .sheet(isPresented: $showModal) {
            ItineraryInputModal(
                folderName: $folderName,
                day: $day,
                onCancel: { showModal = false },
                onSave: {
                    showModal = false
                    isSaved = true
                }
            )
        }
    }
}
#Preview {
    ItineraryCreate()
}
