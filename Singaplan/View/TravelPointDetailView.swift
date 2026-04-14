import SwiftUI

struct TravelPointDetailView: View {
    var district: District? = nil
    var poi: POI? = nil
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    // Tracks which priority cards are currently expanded
    @State private var isPriorityExpanded: Bool = false
    @State private var showSavedItineraryMessage: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    VStack(alignment: .leading, spacing: 16) {
                        infoSection
                        Divider()
                        categorySection
                        let activePriorities = district?.priorities ?? poi?.priorities ?? []
                        //if the poi has zero priorities
                        if !activePriorities.isEmpty {
                            Divider()
                            prioritySection
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .toolbar {
                // Top Left Button (Close)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        withAnimation { showSavedItineraryMessage = true }
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            withAnimation { showSavedItineraryMessage = false
//                            }
//                        }
//                    })
//                    {
//                        Image(systemName: "square.and.arrow.up")
//                            .font(.system(size: 16, weight: .bold))
//                            .foregroundColor(.white)
//                            .frame(width: 36, height: 36)
//                            .background(Color.blue)
//                            .clipShape(Circle())
//                    }
//                }
            }
        }
        .overlay(
            VStack {
                Spacer() //so the animation is pushed down on the screen
                if showSavedItineraryMessage {
                    Text("Saved to itinerary")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Capsule().fill(Color.blue.opacity(0.8)))
                        .shadow(radius: 5)
                        .padding(.bottom, 40)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        )
    }
    // MARK: - 1. Header Section
    private var headerSection: some View {
        ZStack(alignment: .top) {
            TabView {
                let activePhotos = district?.photoUrls ?? poi?.photoUrls ?? []
                
                ForEach(activePhotos, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 350)
                        .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 350)
        }
    }
    // MARK: - 2. Info Section
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // IF DISTRICT IS CHOSEN:
            if let currentDistrict = district {
                Text(currentDistrict.name).font(.title).fontWeight(.bold)
                HStack {
                    Image(systemName: "mappin.and.ellipse").foregroundColor(.red)
                    Text(currentDistrict.address).font(.subheadline).foregroundColor(.secondary)
                }
                Text(currentDistrict.desc).font(.body).foregroundColor(.secondary).lineLimit(3)
                
            // IF POI IS CHOSEN:
            } else if let currentPOI = poi {
                Text(currentPOI.name).font(.title).fontWeight(.bold)
                
                // checks if the POI has open and close time
                if let _ = currentPOI.openTime, let close = currentPOI.closeTime {
                    HStack(spacing: 4) {
                        Text("Open").fontWeight(.semibold).foregroundColor(.green)
                        Text("- Closes \(close)").foregroundColor(.secondary)
                    }
                    .font(.subheadline)
                }
                
                HStack {
                    Image(systemName: "mappin.and.ellipse").foregroundColor(.red)
                    Text(currentPOI.address).font(.subheadline).foregroundColor(.secondary)
                }
                Text(currentPOI.desc).font(.body).foregroundColor(.secondary).lineLimit(3)
            }
        }
    }
    // MARK: - 3. Category Section
    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Category")
                .font(.headline)
                .fontWeight(.bold)
            let activeCategories = district?.categories ?? poi?.categories ?? []
            // FlowLayout so capsules size naturally and wrap gracefully
            FlowLayout() {
                ForEach(activeCategories) { category in
                    CategoryCapsule(
                        child: category,
                        isSelected: false
                    )
                }
            }
        }
    }

    // MARK: - 4. Priority Section
    private var prioritySection: some View {
            VStack(spacing: 0) {
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPriorityExpanded.toggle() // Opens or closes the single card
                    }
                })
                {
                    HStack {
                        Text("Priority Overview")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: isPriorityExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.primary)
                    }
                    .padding()
                }
                
                // --- EXPANDED TEXT SUMMARY ---
                if isPriorityExpanded {
                    Divider()
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        let activePriorities = district?.priorities ?? poi?.priorities ?? [] //checks district, if its empty, it checks POI, if both empty then blank
                        // Loop through all priorities and show them as plain text rows
                        ForEach(activePriorities) { priority in
                            makePriorityCard(for: priority)
                        }
                    }
                    .padding()
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
    
    // MARK: - 5. Make Priority Row Function
    private func makePriorityCard(for priority: Priority) -> some View {
    // Find the text label that matches the user's selected weight
            // Works for the final data too later.
            let selectedSegment = priority.segments.first(where: { $0.weight == priority.selectedWeight })
            
            // DUMMY DATA, forces $$ from the priority mock data
            let chosenText = selectedSegment?.label ?? ""
            
            //
            return HStack {
                // Left side (e.g., "Popularity", "Mobility", "Budget")
                Text(priority.title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                // line to separated, not a must, can be removable
                Rectangle()
                    .fill(Color.gray.opacity(0.3)) // A very faint, low-opacity gray
                    .frame(height: 1)
                    .padding(.horizontal, 8)
                Spacer()
                
                // Right side (e.g., "Mixed", "Standard", "$$")
                Text(chosenText)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 2)
        }
    
    // MARK: - Preview Provider
    struct TravelPointDetailView_Previews: PreviewProvider {
        static var previews: some View {
            
            // --- 1. MOCK DISTRICT ---
            let mockDistrict = District(
                name: "Sentosa Island",
                address: "Sentosa Gateway, Singapore",
                desc: "A sunny island resort in Singapore, home to themed attractions, sandy beaches, rainforests, and amazing dining experiences.",
                photoUrls: ["sentosa", "sentosa-2", "sentosa-3"],
                priorities: [
                    Priority(
                        title: "Budget",
                        desc: "Overall cost",
                        segments: [
                            PrioritySegment(label: "$", weight: 0.1),
                            PrioritySegment(label: "$$", weight: 0.5),
                            PrioritySegment(label: "$$$", weight: 1.0)
                        ]
                    ),
                    Priority(
                        title: "Additional Fee",
                        desc: "",
                        segments: [
                            PrioritySegment(label: "Include Fees", weight: 0.1),
                            PrioritySegment(label: "No Fees Only", weight: 0.5)
                        ]
                    ),
                    SeedData.experiences[0], // Popularity
                    SeedData.experiences[1], // Proximity
                    SeedData.experiences[2], // Pace
                    SeedData.accessibility[0], // Mobility
                    SeedData.accessibility[1], // Transport
                    SeedData.accessibility[2], // Walkability
                ],
                categories: [
                    Category(title: "Nature", icon: "leaf.fill"),
                    Category(title: "Family", icon: "figure.2.and.child.holdinghands"),
                    Category(title: "Beach", icon: "sun.max.fill"),
                    Category(title: "Attraction", icon: "fork.knife.circle.fill")
                ]
            )
            
            // --- 2. MOCK POI ---
            let mockPOI = POI(
                name: "Universal Studios Singapore",
                desc: "Go beyond the screen and Ride The Movies at Universal Studios Singapore.",
                address: "8 Sentosa Gateway, Singapore",
                photoUrls: ["universal_studios"],
                openTime: "10:00 am", // ✅ POI gets the times!
                closeTime: "19:00 pm",
                // Note: I left photo nil here, but you can pass a dummy Photo object if you have one!
                priorities: [
                    SeedData.experiences[0], // Popularity
                    SeedData.experiences[1], // Proximity
                    SeedData.experiences[2], // Pace
                    SeedData.accessibility[0], // Mobility
                    SeedData.accessibility[1], // Transport
                    SeedData.accessibility[2], // Walkability
                ],
                categories: [
                    Category(title: "Attraction", icon: "star.fill")
                ]
            )
            
            // --- 3. SHOW BOTH IN PREVIEW ---
            Group {
//                 Previews the District version
                TravelPointDetailView(district: mockDistrict)
                    .previewDisplayName("District View")
                
                // Previews the POI version
                TravelPointDetailView(poi: mockPOI)
                    .previewDisplayName("POI View")
            }
        }
    }
}
//
//#Preview {
//    TravelPointDetailView()
//}


