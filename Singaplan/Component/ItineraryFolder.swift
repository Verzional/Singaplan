//
//  ItineraryFolder.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 10/04/26.
//

import SwiftUI

struct ItineraryFolder: View {
    var folderName: String
    var days: String
    var backgroundImageName: String?
    var onBack: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(folderName)
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()
                
                Text("\(days) Days")
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.9))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height:100)
        .background(
            ZStack {
                if let imageName = backgroundImageName, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 85)
                        .clipped()
                    
                    LinearGradient(
                        gradient: Gradient(colors: [.black.opacity(0.6), .black.opacity(0.2), .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                } else {
                    Color.black
                }
            }
        )
        .cornerRadius(16)
    }
}

// MARK: - Preview
#Preview("Hitung Kartu Hitam") {
    ItineraryFolder(
        folderName: "Girls Trip",
        days: "4",
        backgroundImageName: nil,
        onBack: { print("Back") }
    )
    .padding()
}

#Preview("Hitung Kartu Gambar") {
    ItineraryFolder(
        folderName: "Singapore Trip",
        days: "3",
        backgroundImageName: "marina-bg",
        onBack: { print("Back") }
    )
    .padding()
}
