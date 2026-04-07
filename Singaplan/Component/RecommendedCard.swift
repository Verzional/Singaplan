//
//  RecommendedCard.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import SwiftUI

struct RecommendedCard: View {
    // In a real scenario, you'd pass your Model here
    // let destination: POI

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            //Image
            Image("universal_studios")
                .resizable()
                .scaledToFill()
                .frame(width: 135)
                .clipped()

            //Content
            VStack(alignment: .leading, spacing: 2) {
                headerSection
                
                priceRatingSection
                
                //Added Info
                VStack(alignment: .leading, spacing: 2) {
                    Text("Easy-Accessibility")
                    Text("Crowded on Holiday Season")
                }
                .font(.system(size: 14))
                .foregroundColor(.secondary)

                CategoryCapsule(
                    child: CategoryModel(title: "Family", icon: "figure.2.and.child.holding_hands"),
                    isSelected: false
                )
                .scaleEffect(0.8)
                .padding(.leading, -10)
                
                Spacer(minLength: 4)

                footerSection
            }
            .padding(12)
        }
        .frame(height: 180)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}

extension RecommendedCard {
    
    private var headerSection: some View {
        HStack {
            Text("Universal Studios")
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Image(systemName: "info.circle")
                .foregroundColor(.secondary)
        }
    }

    private var priceRatingSection: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(index < 2 ? .gray : Color(.systemGray4))
            }
        }
        .padding(.bottom, 2)
    }

    private var footerSection: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Transport Options:")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.secondary)
                
                HStack(spacing: 10) {
                    transportItem(icon: "bus.fill", label: "Bus")
                    transportItem(icon: "tram.fill", label: "MRT")
                }
            }
            
            Spacer()
            
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 28))
                .foregroundColor(.blue)
        }
    }

    // Helper function for transport items to keep code DRY
    private func transportItem(icon: String, label: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(label)
        }
        .font(.system(size: 13))
        .foregroundColor(.primary)
    }
}


#Preview {
    RecommendedCard()
}
