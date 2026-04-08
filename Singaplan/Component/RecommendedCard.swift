import SwiftUI

struct RecommendedCard: View {
    let place: Place

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(place.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 135)
                .frame(maxHeight: .infinity)
                .clipped()

            VStack(alignment: .leading, spacing: 2) {
                headerSection
                
                priceRatingSection
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(place.description)
                        .lineLimit(2)
                }
                .font(.system(size: 14))
                .foregroundColor(.secondary)

                HStack(spacing: 5) {
                    ForEach(place.tags, id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 10, weight: .bold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 4)
                
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
                Text(place.name)
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
    RecommendedCard(place: Place.Places[0])
}
