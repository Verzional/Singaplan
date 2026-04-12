import SwiftUI

// MARK: - Search Result Wrapper
enum SearchResult: Identifiable {
    case district(District)
    case poi(POI)
    
    var id: String {
        switch self {
        case .district(let d): return d.id.uuidString
        case .poi(let p): return p.id
        }
    }
    
    var name: String {
        switch self {
        case .district(let d): return d.name
        case .poi(let p): return p.name
        }
    }
    
    var description: String {
        switch self {
        case .district(let d): return d.desc
        case .poi(let p): return p.desc
        }
    }
    
    var imageName: String {
        switch self {
        case .district(let d): return d.photoUrls.first ?? ""
        case .poi(let p): return p.photos.first?.url ?? ""
        }
    }
    
    var categories: [Category] {
        switch self {
        case .district(let d): return d.categories ?? []
        case .poi(let p):
            if let sub = p.subcategory { return [sub] }
            return []
        }
    }
}

// MARK: - View
struct RecommendedCard: View {
    let result: SearchResult
    var onAdd: (() -> Void)? = nil
    
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

// MARK: - Sections
extension RecommendedCard {
    private var spotlightImage: some View {
        Group {
            if !result.imageName.isEmpty {
                Image(result.imageName)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray.opacity(0.3) // Fallback if no image exists
            }
        }
        .frame(width: 135)
        .frame(maxHeight: .infinity)
        .clipped()
    }
    
    private var headerSection: some View {
        HStack {
            Text(result.name)
                .font(.system(size: 20, weight: .bold))
                .lineLimit(1)
            Spacer()
            Button {
                print("Info tapped for \(result.name)")
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
            ForEach(result.categories) { category in
                CategoryCapsule(child: category, isSelected: false)
                    .scaleEffect(0.8)
            }
        }
        .padding(.top, 4)
    }
    
    private var placeDescription: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(result.description)
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
                Text(result.categories.isEmpty ? "" : "Options:")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.secondary)
                
                HStack(spacing: 10) {
                    if case .district = result {
                        transportItem(icon: "building.2.fill", label: "District")
                    } else {
                        transportItem(icon: "mappin.circle.fill", label: "POI")
                    }
                }
            }
            
            Spacer()
            
            Button {
                onAdd?()
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
