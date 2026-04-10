

//
//  ItineraryInputModal.swift
//  Singaplan
//
//  Created by Michelle on 07/04/26.
//

import SwiftUI

struct ItineraryInputModalView: View {
// MARK: State Variables
    @Binding var folderName: String
    @Binding var day: String
    var onCancel: () -> Void
    var onSave: () -> Void
    
// MARK: Body (Folder Input)
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
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
                .padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("Number of Days")
                        .font(.system(size: 20))
                        .bold()
                    
                    TextField("Enter number of days", text: $day)
                        .padding(.bottom, 5)
                        .overlay(Rectangle().frame(height: 1), alignment: .bottom)
                        .keyboardType(.numberPad)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: onCancel) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .bold))
                            .padding(5)
                            .clipShape(Circle())
                    }
                }

// MARK: Toolbar
                ToolbarItem(placement: .principal) {
                    Text("Set Your Itinerary Folder")
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.center)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: onSave) {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 25, height: 25)
                        .padding(5)
                        .background(Color.blue)
                        .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    ItineraryInputModalView(
        folderName: .constant("Girls Trip"),
        day: .constant("4"),
        onCancel: { print("Tombol X ditekan") },
        onSave: { print("Tombol Simpan ditekan") }
    )
}
