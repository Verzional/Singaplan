//
//  DestinationCard.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI
import SwiftData


// MARK: POI Card
struct DestinationCard: View {
    let poi: POI
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            if let firstPhoto = poi.photos.first {
                Color.clear
                    .overlay(
                        Image(firstPhoto.url)
                            .resizable()
                            .scaledToFill()
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray5))
            }
            
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.2)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 2) {
                if let districtName = poi.district?.name {
                    Text(districtName.uppercased())
                        .font(.system(size: 10))
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .background(Color.red.opacity(0.6))
                }
                
                Text(poi.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
            .padding(10)
        }
        .contentShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - District Card
struct DistrictCard: View {
    let district: District
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            Color.clear
                .overlay(
                    Image(district.photoUrls[1])
                        .resizable()
                        .scaledToFill()
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.2)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading, spacing: 2) {
                Text("District")
                    .font(.system(size: 10))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .background(Color.blue.opacity(0.6))
                
                Text(district.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(10)
        }
        .contentShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: Preview
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: POI.self, District.self, Photo.self, configurations: config)

    let sampleDistrict = District(
        name: "Chinatown",
        address: "Central Region",
        desc: "Historic area",
        photoUrl: ["marina-bg"]
    )
    
    VStack(spacing: 20) {
        Text("District Card Example:")
            .font(.caption)
        
        DistrictCard(district: sampleDistrict)
        
        Divider()
        
        Text("POI Card Example:")
            .font(.caption)
        
        DestinationCard(poi: POI(
            id: "1",
            name: "Buddha Tooth Relic",
            desc: "Temple",
            location: "Chinatown",
            district: sampleDistrict,
            photo: Photo(id: "p1", url: "buddha-tooth-relic-temple.png")
        ))
        .frame(width: 150, height: 150)
    }
    .modelContainer(container)
}
