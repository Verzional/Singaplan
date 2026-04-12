import SwiftUI

struct RecommendedCard: View {
    let place: Place
    var onAdd: (() -> Void)? = nil
    
    //MARK: Body
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            spotlightImage
            VStack(alignment: .leading, spacing: 2) {
                headerSection
                priceRatingSection
                placeDescription
                categorySection
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

//MARK: Sections
extension RecommendedCard {
    
    private var spotlightImage: some View {
        Image(place.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 135)
            .frame(maxHeight: .infinity)
            .clipped()
    }
    
    private var headerSection: some View {
        HStack {
            Text(place.name)
                .font(.system(size: 20, weight: .bold))
            Spacer()
            Button {
                print("Info tapped for \(place.name)")
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.secondary)
                    .font(.system(size: 18))
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
    
    private var categorySection: some View {
        HStack(spacing: 0) {
            ForEach(place.categories) { category in
                CategoryCapsule(child: category, isSelected: false)
                    .scaleEffect(0.8)
            }
        }
        .padding(.top, 4)
        
    }
    
    private var placeDescription: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(place.description)
                .lineLimit(2)
        }
        .font(.system(size: 14))
        .foregroundColor(.secondary)
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
            
            Button {
                if let onAdd = onAdd {
                    onAdd()
                } else {
                    print("Added \(place.name) to list")
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.blue)
            }
            .buttonStyle(.plain)
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
//MARK: Preview
#Preview {
    RecommendedCard(place: Place.Places[1])
}
