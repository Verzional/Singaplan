import SwiftUI

// MARK: - Wrapper
enum SearchResult: Identifiable {
    case district(District)
    case poi(POI)
    
    var id: String {
        switch self {
        case .district(let d): return d.id.uuidString
        case .poi(let p): return p.id.uuidString
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
        case .poi(let p): return p.photoUrls.first ?? ""
        }
    }
    
    var categories: [Category] {
        switch self {
        case .district(let d):
            return d.categories ?? []
        case .poi(let p):
            return p.categories ?? []
        }
    }
}

// MARK: - View
struct RecommendedCard: View {
    let result: SearchResult
    let isSelected: Bool
    var onAdd: (() -> Void)? = nil
    var onInfoTapped: (() -> Void)? = nil

    @State private var isAdded: Bool = false
    
    init(
        district: District,
        isSelected: Bool = false,
        onAdd: (() -> Void)? = nil,
        onInfoTapped: (() -> Void)? = nil
    ) {
        self.result = .district(district)
        self.isSelected = isSelected
        self.onAdd = onAdd
        self.onInfoTapped = onInfoTapped
    }
    
    init(
        poi: POI,
        isSelected: Bool = false,
        onAdd: (() -> Void)? = nil,
        onInfoTapped: (() -> Void)? = nil
    ) {
        self.result = .poi(poi)
        self.isSelected = isSelected
        self.onAdd = onAdd
        self.onInfoTapped = onInfoTapped
    }
    
    init(
        result: SearchResult,
        isSelected: Bool = false,
        onAdd: (() -> Void)? = nil,
        onInfoTapped: (() -> Void)? = nil
    ) {
        self.result = result
        self.isSelected = isSelected
        self.onAdd = onAdd
        self.onInfoTapped = onInfoTapped
    }
    
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
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .overlay {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.blue, lineWidth: 2)
                    }
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
        .animation(.snappy, value: isSelected)
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
                Color.gray.opacity(0.3)
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
                onInfoTapped?()
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
        let categories = result.categories
        let visible = categories.prefix(1)
        let extraCount = max(categories.count - visible.count, 0)
        
        return HStack(spacing: 0) {
            ForEach(Array(visible)) { category in
                CategoryCapsule(child: category, isSelected: false)
                    .scaleEffect(0.8)
            }
            
            if extraCount > 0 {
                HStack(spacing: 4) {
                    Text("+ \(extraCount)")
                }
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.blue)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule().fill(Color.blue.opacity(0.12))
                )
                //                .scaleEffect(0.8, anchor: .leading)
            }
        }
        .padding(.top, 4)
        .padding(.leading, -10)
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
            ForEach(0..<3) { index in
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(index < 2 ? .gray : Color(.systemGray4))
            }
        }
        .padding(.bottom, 2)
    }
    
    private var footerSection: some View {
        HStack(alignment: .bottom) {
            //            VStack(alignment: .leading, spacing: 4) {
            ////                Text(result.categories.isEmpty ? "" : "Options:")
            ////                    .font(.system(size: 11, weight: .semibold))
            ////                    .foregroundColor(.secondary)
            //
            //                HStack(spacing: 10) {
            //                    if case .district = result {
            //                        transportItem(icon: "building.2.fill", label: "District")
            //                    } else {
            //                        transportItem(icon: "mappin.circle.fill", label: "POI")
            //                    }
            //                }
            //            }
            
            Spacer()
            
            Button {
                guard !isAdded else { return }
                onAdd?()
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isAdded = true
                }
            } label: {
                Image(systemName: isAdded ? "checkmark.circle.fill" : "plus.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(isAdded ? .green : .blue)
                    .scaleEffect(isAdded ? 1.1 : 1.0)
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

// MARK: - Preview
#Preview("District") {
    let mockDistrict = District(
        name: "Marina Bay",
        address: "Marina Bay, Singapore",
        desc: "Iconic skyline, waterfront promenade, and world-class attractions.",
        photoUrls: ["singapore"],
        priorities: [],
        categories: [
            Category(title: "Scenic", icon: "camera.fill"),
            Category(title: "Nightlife", icon: "moon.stars.fill"),
            Category(title: "Nature", icon: "leaf.fill")
        ]
    )
    
    RecommendedCard(district: mockDistrict, onInfoTapped:  {
        print("Add district tapped")
    })
}

#Preview("POI") {
    let mockPOI = POI(
        name: "Gardens by the Bay",
        desc: "Futuristic park featuring Supertree Grove and climate-controlled conservatories.",
        address: "18 Marina Gardens Dr, Singapore",
        photoUrls: ["singapore"],
        openTime: "09:00",
        closeTime: "21:00",
        priorities: [],
        categories: [
            Category(title: "Nature", icon: "leaf.fill"),
            Category(title: "Attraction", icon: "star.fill")
        ]
    )
    
    RecommendedCard(poi: mockPOI, onInfoTapped:  {
        print("Add POI tapped")
    })
}

