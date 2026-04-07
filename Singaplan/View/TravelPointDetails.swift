import SwiftUI

struct TravelPointDetailView: View {
    let district: District
    @Environment(\.presentationMode) var presentationMode
    
    // Tracks which priority cards are currently expanded
    @State private var expandedPriorityIDs: Set<String> = []
    @State private var showSavedItineraryMessage: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerSection
                VStack(alignment: .leading, spacing: 16) {
                    infoSection
                    Divider()
                    categorySection
                    prioritySection
                    Divider()
                    poiSection
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .overlay(
            VStack {
                Spacer() // Pushes the message to the bottom of the screen
                
                if showSavedItineraryMessage {
                    Text("Saved to itinerary")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Capsule().fill(Color.black.opacity(0.8)))
                        .shadow(radius: 5)
                        .padding(.bottom, 40)
                        .transition(.move(edge: .bottom).combined(with: .opacity)) //animation slide & fade
                }
            }
        )
    }
    // MARK: - 1. Header Section
    private var headerSection: some View {
        ZStack(alignment: .top) {
            TabView {
                ForEach(district.photoUrls, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 350)
                        .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 350)
            
            // Top Navigation Buttons
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 36, height: 36)
                        .background(Color.white.opacity(0.9))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Button(action: {
                    //Show the message with a smooth animation
                    withAnimation {
                        showSavedItineraryMessage = true
                    }
                    
                    //animation -> hide after 2secs
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showSavedItineraryMessage = false
                        }
                    }
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 50)
        }
    }
    // MARK: - 2. Info Section
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title & Open Data
            VStack(alignment: .leading, spacing: 8) {
                Text(district.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack(spacing: 4) {
                    Text("Open")
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                    Text("- Closes \(district.closeTime)")
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)
                
                Text(district.priceRange)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            
            // Location & Description
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.red)
                    Text(district.address)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Text(district.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
    }
    // MARK: - 3. Category Section
    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Category")
                .font(.headline)
                .fontWeight(.bold)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .leading, spacing: 10) {
               
                ForEach(district.categories) { category in
                
                    CategoryCapsule(child: category, isSelected: false)
                }
            }
        }
    }
    // MARK: - 4. Priority Section
    private var prioritySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Priority")
                .font(.headline)
                .fontWeight(.bold)
            
            ForEach(district.priorities) { priority in
                // Check if this specific priority's ID is in our expanded set
                let isExpanded = expandedPriorityIDs.contains(priority.id)
                
                VStack(spacing: 0) {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            // Toggle the ID in the set
                            if isExpanded {
                                expandedPriorityIDs.remove(priority.id)
                            } else {
                                expandedPriorityIDs.insert(priority.id)
                            }
                        }
                    }) {
                        HStack {
                            Text(priority.name)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                .foregroundColor(.primary)
                        }
                        .padding()
                    }
                    
                    if isExpanded {
                        Divider()
                            .padding(.horizontal)
                        Text(priority.details)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
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
        }
    }
    
    // MARK: - 5. POI Section
    private var poiSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recommended POIs")
                .font(.headline)
                .fontWeight(.bold)
            
            ForEach(district.recommendedPOIs) { poi in
                HStack(spacing: 16) {
                    Image(poi.imageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(poi.name)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(poi.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    Spacer()
                    Button(action: {
                        // Action to add this POI to itinerary
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
    
    // MARK: - Preview Provider
    struct TravelPointDetailView_Previews: PreviewProvider {
        static var previews: some View {
            let mockDistrict = District(
                name: "Sentosa Island",
                address: "Sentosa Gateway, Singapore",
                description: "A sunny island resort in Singapore, home to themed attractions, sandy beaches, rainforests, and amazing dining experiences.",
                openTime: "09:00 am",
                closeTime: "22:00 pm",
                priceRange: "S$ 20.00 - 150.00 per person",
                photoUrls: ["sentosa", "sentosa-2", "sentosa-3"],
                categories: [
                    CategoryModel(title: "Nature", icon: "leaf.fill"),
                    CategoryModel(title: "Family", icon: "figure.2.and.child.holdinghands"),
                    CategoryModel(title: "Beach", icon: "sun.max.fill"),
                    CategoryModel(title: "Food", icon: "fork.knife.circle.fill")
                ],
                priorities: [
                    Priority(name: "Budget", details: "Price: $$\nAdditional Fee: Minimal"),
                    Priority(name: "Accessibility", details: "Wheelchair accessible. Easily reachable by Sentosa Express or Cable Car."),
                    Priority(name: "Experience", details: "High throughput, expect crowds during holiday seasons.")
                ],
                recommendedPOIs: [
                    POI(name: "Universal Studios", description: "World-class theme park with exciting rides.", location: "Resorts World", imageUrl: ""),
                    POI(name: "S.E.A. Aquarium", description: "One of the world's largest aquariums.", location: "Resorts World", imageUrl: ""),
                    POI(name: "Palawan Beach", description: "Family-friendly beach with a suspension bridge.", location: "Sentosa South", imageUrl: "")
                ]
            )
            
            TravelPointDetailView(district: mockDistrict)
        }
    }
}

//#Preview {
//    TravelPointDetailView()
//}


