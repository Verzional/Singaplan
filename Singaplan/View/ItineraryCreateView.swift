

//
//  ItineraryInputModal.swift
//  Singaplan
//
//  Created by Michelle on 07/04/26.
//

import SwiftUI

struct ItineraryCreateView: View {
    // MARK: - State Variables
    @Binding var folderName: String
    @Binding var day: Int
    
    var onCancel: () -> Void
    var onSave: () -> Void
    
    // MARK: - Body (Folder Input)
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                folderNameField
                numberOfDaysField
                Spacer()
            }
            .padding()
            .navigationTitle("Set Your Itinerary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                navigationToolbar
            }
        }
    }
}

// MARK: - View Components
private extension ItineraryCreateView {
    var folderNameField: some View {
        VStack(alignment: .leading) {
            Text("Folder Name")
                .bold()
                .font(.system(size: 20))
            
            TextField("Enter folder name", text: $folderName)
                .padding(.bottom, 5)
                .overlay(
                    Rectangle()
                        .frame(height: 1),
                    alignment: .bottom
                )
        }
    }
    
    var numberOfDaysField: some View {
        VStack(alignment: .leading) {
            Text("Number of Days")
                .font(.system(size: 20))
                .bold()
            
            TextField("Enter number of days", value: $day, format: .number)
                .padding(.bottom, 5)
                .overlay(Rectangle().frame(height: 1), alignment: .bottom)
                .keyboardType(.numberPad)
        }
    }
    
    var navigationToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: onCancel) {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: onSave) {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .clipShape(Circle())
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ItineraryCreateView(
        folderName: .constant("Girls Trip"),
        day: .constant(5),
        onCancel: { print("Tombol X ditekan") },
        onSave: { print("Tombol Simpan ditekan") }
    )
}
