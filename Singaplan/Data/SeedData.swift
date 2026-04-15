//
//  SeedData.swift
//  Singaplan
//

struct SeedData {
    // MARK: - Categories
    static let nature = Category(title: "Nature & Outdoors")
    static let culture = Category(title: "Culture & History")
    static let metro = Category(title: "Metropolitan")
    static let supernatural = Category(title: "Supernatural")
    static let culinary = Category(title: "Culinary")
    static let shopping = Category(title: "Shopping")
    static let entertainment = Category(title: "Entertainment")
    static let kids = Category(title: "Kids & Family")
    
    // Subcategories
    static let categories: [Category] = [
        Category(title: "Mountain", icon: "mountain.2", parent: nature),
        Category(title: "Marine", icon: "water.waves", parent: nature),
        Category(title: "Wildlife", icon: "pawprint", parent: nature),
        Category(title: "Forest", icon: "tree", parent: nature),
        Category(title: "Artistic", icon: "paintpalette", parent: culture),
        Category(title: "Ancient", icon: "laurel.leading.laurel.trailing", parent: culture),
        Category(title: "Festive", icon: "party.popper", parent: culture),
        Category(title: "Mega City", icon: "building.2", parent: metro),
        Category(title: "Smart City", icon: "antenna.radiowaves.left.and.right", parent: metro),
        Category(title: "Celestial", icon: "sparkles", parent: supernatural),
        Category(title: "Spiritual", icon: "hands.and.sparkles", parent: supernatural),
        Category(title: "Fine Dining", icon: "fork.knife", parent: culinary),
        Category(title: "Street Food", icon: "flame", parent: culinary),
        Category(title: "Cafe & Bakery", icon: "cup.and.saucer", parent: culinary),
        Category(title: "Hawker Centre", icon: "frying.pan", parent: culinary),
        Category(title: "Shopping Mall", icon: "bag", parent: shopping),
        Category(title: "Local Market", icon: "cart", parent: shopping),
        Category(title: "Beach & Coast", icon: "beach.umbrella", parent: nature),
        Category(title: "Themepark", icon: "ticket", parent: entertainment),
        Category(title: "Live Shows", icon: "theatermasks", parent: entertainment),
        Category(title: "Viewpoint", icon: "binoculars", parent: metro),
        Category(title: "Science", icon: "atom", parent: culture),
        Category(title: "Family Play", icon: "figure.2.and.child.holdinghands", parent: kids),
        Category(title: "Edutainment", icon: "lightbulb", parent: kids),
        Category(title: "Nightlife", icon: "wineglass", parent: entertainment),
    ]
    
    static var categoryData: [Category] {
        return [nature, culture, metro, supernatural, culinary, shopping, entertainment, kids] + categories
    }
    
    //MARK: - Priorities
    static let experiences: [Priority] = [
        Priority(
            title: "Popularity",
            desc: "Balance your trip between world-renowned icons and under-the-radar local secrets.",
            segments: [
                PrioritySegment(label: "Hidden Gems", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Iconic Hits", weight: 1.0)
            ]
        ),
        Priority(
            title: "Proximity",
            desc: "Prioritize areas with high concentrations of things to do, or spread out for a more spacious journey.",
            segments: [
                PrioritySegment(label: "Spaced Out", weight: 0.1),
                PrioritySegment(label: "Balanced", weight: 0.5),
                PrioritySegment(label: "Action-Packed", weight: 1.0)
            ]
        ),
        Priority(
            title: "Pace",
            desc: "Weight your day toward quick, high-variety 'snapshots' or deeper, time-intensive immersions.",
            segments: [
                PrioritySegment(label: "Snapshots", weight: 0.1),
                PrioritySegment(label: "Steady", weight: 0.5),
                PrioritySegment(label: "Deep Dives", weight: 1.0)
            ]
        )
    ]
    
    static let accessibility: [Priority] = [
        Priority(
            title: "Mobility",
            desc: "Prioritize level, easy-access paths or embrace more rugged, adventurous surfaces.",
            segments: [
                PrioritySegment(label: "Rugged", weight: 0.1),
                PrioritySegment(label: "Standard", weight: 0.5),
                PrioritySegment(label: "Seamless", weight: 1.0)
            ]
        ),
        Priority(
            title: "Transport",
            desc: "Choose between secluded spots with one way in or vibrant hubs with every way to arrive.",
            segments: [
                PrioritySegment(label: "Single", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Versatile", weight: 1.0)
            ]
        ),
        Priority(
            title: "Walkability",
            desc: "Balance your trip between vehicle-heavy roads and pedestrian-first zones with tram lines.",
            segments: [
                PrioritySegment(label: "Vehicle", weight: 0.1),
                PrioritySegment(label: "Mixed", weight: 0.5),
                PrioritySegment(label: "Pedestrian", weight: 1.0)
            ]
        )
    ]
    
    static var priorityData: [Priority] {
        return experiences + accessibility
    }
    
    static func createDistrictPriorities(
        popularity: Double,
        proximity: Double,
        pace: Double,
        mobility: Double,
        transport: Double,
        walkability: Double
    ) -> [Priority] {
        let pop = Priority(title: experiences[0].title, desc: experiences[0].desc, segments: experiences[0].segments)
        pop.selectedWeight = popularity
        let prox = Priority(title: experiences[1].title, desc: experiences[1].desc, segments: experiences[1].segments)
        prox.selectedWeight = proximity
        let pa = Priority(title: experiences[2].title, desc: experiences[2].desc, segments: experiences[2].segments)
        pa.selectedWeight = pace
        let mob = Priority(title: accessibility[0].title, desc: accessibility[0].desc, segments: accessibility[0].segments)
        mob.selectedWeight = mobility
        let trans = Priority(title: accessibility[1].title, desc: accessibility[1].desc, segments: accessibility[1].segments)
        trans.selectedWeight = transport
        let walk = Priority(title: accessibility[2].title, desc: accessibility[2].desc, segments: accessibility[2].segments)
        walk.selectedWeight = walkability
        return [pop, prox, pa, mob, trans, walk]
    }
    
    // MARK: - Districts
    static let marina_bay = District(
        name: "Marina Bay",
        address: "Singapore",
        desc: "The crown jewel of Singapore’s skyline. A futuristic waterfront area home to world-class resorts, high-end shopping, and iconic architecture.",
        photoUrls: ["marina-bay_1", "marina-bay_2"],
        priorities: createDistrictPriorities(
            popularity: 0.98, proximity: 0.90, pace: 0.50, mobility: 0.95, transport: 0.95, walkability: 0.90
        ),
        categories: [categories[5], categories[24], categories[4]]
    )

    static let marina_south = District(
        name: "Marina South",
        address: "Singapore",
        desc: "A massive reclaimed area dedicated to green innovation and sustainability, primarily featuring the famous Gardens by the Bay.",
        photoUrls: ["marina-south_1", "marina-south_2"],
        priorities: createDistrictPriorities(
            popularity: 0.95, proximity: 0.85, pace: 0.40, mobility: 0.90, transport: 0.90, walkability: 0.80
        ),
        categories: [nature, categories[17]]
    )

    static let civic_district = District(
        name: "Civic District",
        address: "Singapore",
        desc: "The birthplace of modern Singapore. This area is packed with historical colonial buildings, national museums, and grand monuments.",
        photoUrls: ["civic-district_1", "civic-district_2"],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.85, pace: 0.40, mobility: 0.90, transport: 0.90, walkability: 0.95
        ),
        categories: [entertainment, nature]
    )

    static let downtown = District(
        name: "Downtown",
        address: "Singapore",
        desc: "The financial heart of the city. A high-energy district where sleek skyscrapers stand alongside historic markets and riverside nightlife.",
        photoUrls: ["downtown_1", "downtown_2"],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.80, pace: 0.40, mobility: 0.75, transport: 0.90, walkability: 0.90
        ),
        categories: [nature, entertainment]
    )

    static let orchard_road = District(
        name: "Orchard Road",
        address: "Singapore",
        desc: "Singapore’s premier shopping belt. A bustling boulevard lined with futuristic malls, luxury boutiques, and flagship department stores.",
        photoUrls: ["orchard-road_1", "orchard-road_2"],
        priorities: createDistrictPriorities(
            popularity: 0.95, proximity: 0.90, pace: 0.30, mobility: 0.95, transport: 1.00, walkability: 1.00
        ),
        categories: [supernatural, culture]
    )

    static let chinatown = District(
        name: "Chinatown",
        address: "Singapore",
        desc: "A vibrant cultural enclave blending traditional Chinese heritage, historic temples, and legendary hawker stalls with trendy bars.",
        photoUrls: ["chinatown_1", "chinatown_2"],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.80, pace: 0.40, mobility: 0.75, transport: 0.90, walkability: 0.90
        ),
        categories: [culture, kids]
    )

    static let sentosa_island = District(
        name: "Sentosa Island",
        address: "Singapore",
        desc: "Singapore’s favorite island resort. A dedicated leisure destination for theme parks, sandy beaches, and luxury lifestyle attractions.",
        photoUrls: ["sentosa-island_1", "sentosa-island_2"],
        priorities: createDistrictPriorities(
            popularity: 0.92, proximity: 0.40, pace: 0.70, mobility: 0.85, transport: 0.70, walkability: 0.65
        ),
        categories: [entertainment, nature]
    )

    static let harbourfront = District(
        name: "Harbourfront",
        address: "Singapore",
        desc: "A major gateway connecting the main island to Sentosa, featuring the city’s largest mall and scenic hilltop cable car views.",
        photoUrls: ["harbourfront_1", "harbourfront_2"],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.70, pace: 0.50, mobility: 0.85, transport: 0.90, walkability: 0.80
        ),
        categories: [entertainment, kids]
    )

    static let bukit_merah = District(
        name: "Bukit Merah",
        address: "Singapore",
        desc: "A scenic southern district characterized by lush ridges, coastal accessibility, and the iconic wave-shaped pedestrian bridges.",
        photoUrls: ["bukit-merah_1", "bukit-merah_2"],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.55, pace: 0.70, mobility: 0.70, transport: 0.75, walkability: 0.80
        ),
        categories: [shopping, nature]
    )

    static let little_india = District(
        name: "Little India",
        address: "Singapore",
        desc: "A colorful and aromatic district showcasing the soul of Singapore’s Indian community through bustling markets and ornate temples.",
        photoUrls: ["little-india_1", "little-india_2"],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.75, pace: 0.30, mobility: 0.65, transport: 0.90, walkability: 0.85
        ),
        categories: [shopping, culinary]
    )

    static let kampong_glam = District(
        name: "Kampong Glam",
        address: "Singapore",
        desc: "The historic seat of Malay royalty, now a hip cultural quarter known for its majestic mosque, textile shops, and artistic alleyways.",
        photoUrls: ["kampong-glam_1", "kampong-glam_2"],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.80, pace: 0.40, mobility: 0.80, transport: 0.85, walkability: 0.95
        ),
        categories: [nature, kids]
    )

    static let east_coast = District(
        name: "East Coast",
        address: "Singapore",
        desc: "A beloved residential and recreational stretch famous for its long coastal park, cycling paths, and famous seafood culture.",
        photoUrls: ["east-coast_1", "east-coast_2"],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.45, pace: 0.85, mobility: 0.80, transport: 0.65, walkability: 0.85
        ),
        categories: [nature, culture]
    )

    static let changi = District(
        name: "Changi",
        address: "Singapore",
        desc: "The aviation hub of the world. Beyond the airport, it offers a rustic charm with historical sites and coastal ferry terminals.",
        photoUrls: ["changi_1", "changi_2"],
        priorities: createDistrictPriorities(
            popularity: 0.95, proximity: 0.15, pace: 0.60, mobility: 0.85, transport: 0.80, walkability: 0.70
        ),
        categories: [culture, shopping]
    )

    static let mandai = District(
        name: "Mandai",
        address: "Singapore",
        desc: "The wildlife capital of Singapore. A dedicated nature zone housing world-renowned zoos, safaris, and rainforest conservation parks.",
        photoUrls: ["mandai_1", "mandai_2"],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.15, pace: 0.80, mobility: 0.70, transport: 0.50, walkability: 0.40
        ),
        categories: [shopping, nature]
    )

    static let jurong = District(
        name: "Jurong",
        address: "Singapore",
        desc: "The industrial and educational powerhouse of the West, recently transformed into a beautiful lakeside destination for recreation.",
        photoUrls: ["jurong_1", "jurong_2"],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.30, pace: 0.60, mobility: 0.85, transport: 0.75, walkability: 0.70
        ),
        categories: [shopping, culture]
    )

    static let lim_chu_kang = District(
        name: "Lim Chu Kang",
        address: "Singapore",
        desc: "The quiet countryside of Singapore. A rustic area in the far northwest home to agricultural farms and expansive wetland reserves.",
        photoUrls: ["lim-chu-kang_1", "lim-chu-kang_2"],
        priorities: createDistrictPriorities(
            popularity: 0.55, proximity: 0.10, pace: 0.95, mobility: 0.40, transport: 0.30, walkability: 0.30
        ),
        categories: [entertainment, kids]
    )

    static let bukit_timah = District(
        name: "Bukit Timah",
        address: "Singapore",
        desc: "An upscale residential district that holds Singapore's highest natural point and its most pristine primary rainforest.",
        photoUrls: ["bukit-timah_1", "bukit-timah_2"],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.60, pace: 0.60, mobility: 0.70, transport: 0.70, walkability: 0.70
        ),
        categories: [entertainment, shopping]
    )

    static let bugis = District(
        name: "Bugis",
        address: "Singapore",
        desc: "A high-energy district popular with youth, featuring a mix of air-conditioned shopping malls and vibrant street markets.",
        photoUrls: ["bugis_1", "bugis_2"],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.85, pace: 0.30, mobility: 0.90, transport: 0.95, walkability: 1.00
        ),
        categories: [culinary, culture]
    )

    static let punggol = District(
        name: "Punggol",
        address: "Singapore",
        desc: "Singapore’s premier eco-town. A modern residential district built around a beautiful waterway, perfect for cycling and outdoor fun.",
        photoUrls: ["punggol_1", "punggol_2"],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.20, pace: 0.80, mobility: 0.85, transport: 0.70, walkability: 0.75
        ),
        categories: [culinary, shopping]
    )

    static let central = District(
        name: "Central",
        address: "Singapore",
        desc: "The pulsating heart of Singapore's economy and urban life. A high-density district where soaring skyscrapers meet historic landmarks, offering a blend of premium lifestyle, world-class dining, and a stunning architectural skyline.",
        photoUrls: ["central_1", "central_2"],
        priorities: createDistrictPriorities(
            popularity: 0.96, proximity: 1.00, pace: 0.40, mobility: 0.95, transport: 1.00, walkability: 0.98
        ),
        categories: [supernatural, nature]
    )

    static let river_valley = District(
        name: "River Valley",
        address: "Singapore",
        desc: "A prime residential and lifestyle district nestled between Orchard Road and the Singapore River. Known for its upscale condominiums, trendy cafes, and lush greenery, it offers a sophisticated yet relaxed atmosphere that connects the city's shopping belt to the historic riverside.",
        photoUrls: ["rivervalley_1", "rivervalley_2"],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.90, pace: 0.60, mobility: 0.85, transport: 0.85, walkability: 0.90
        ),
        categories: [culinary, culture]
    )

    static var districtData: [District] {
        return [marina_bay, marina_south, civic_district, downtown, orchard_road, chinatown, sentosa_island, harbourfront, bukit_merah, little_india, kampong_glam, east_coast, changi, mandai, jurong, lim_chu_kang, bukit_timah, bugis, punggol, central, river_valley]
    }

    // MARK: - POIs
    static let poi_national_orchird_garden_2 = POI(
        name: "National Orchird Garden",
        desc: "Located within the Botanic Gardens, it displays the world's largest collection of orchids.",
        address: "1 Cluny Rd, Singapore 259569",
        photoUrls: ["national-orchird-garden_1", "national-orchird-garden_2"],
        openTime: "08:30",
        closeTime: "19:00",
        district: central,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.65, pace: 0.85, mobility: 0.70, transport: 0.75, walkability: 0.80
        )
    )

    static let poi_macritchie_reservoir_3 = POI(
        name: "MacRitchie Reservoir",
        desc: "Nature reserve famous for hiking and the TreeTop Walk.",
        address: "Lornie Rd",
        photoUrls: ["macritchie-reservoir_1", "macritchie-reservoir_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: central,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.55, pace: 0.90, mobility: 0.50, transport: 0.60, walkability: 0.60
        )
    )

    static let poi_henderson_waves_4 = POI(
        name: "Henderson Waves",
        desc: "Singapore's highest pedestrian bridge with a wave-like design.",
        address: "Henderson Rd",
        photoUrls: ["henderson-waves_1", "henderson-waves_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: bukit_merah,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.60, pace: 0.90, mobility: 0.40, transport: 0.65, walkability: 0.70
        )
    )

    static let poi_sands_skypark_observation_deck_5 = POI(
        name: "Sands SkyPark Observation Deck",
        desc: "A massive surfboard-shaped platform offering 360-degree views of Singapore’s skyline.",
        address: "10 Bayfront Ave, Level 57",
        photoUrls: ["sands-skypark-observation-deck_1", "sands-skypark-observation-deck_2"],
        openTime: "11:00",
        closeTime: "21:00",
        district: marina_bay,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.95, proximity: 0.95, pace: 0.60, mobility: 0.90, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_art_science_museum_6 = POI(
        name: "Art Science Museum",
        desc: "An iconic lotus-inspired building hosting immersive exhibitions at the intersection of art and tech.",
        address: "6 Bayfront Ave, Singapore 018974",
        photoUrls: ["art-science-museum_1", "art-science-museum_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: civic_district,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.95, pace: 0.70, mobility: 0.95, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_joo_chiat_7 = POI(
        name: "Joo Chiat",
        desc: "A heritage area known for its colorful Peranakan shophouses and rich multicultural food scene.",
        address: "Joo Chiat Rd, Singapore",
        photoUrls: ["joo-chiat_1", "joo-chiat_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: east_coast,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.50, pace: 0.80, mobility: 0.70, transport: 0.70, walkability: 0.85
        )
    )

    static let poi_sungei_buloh_wetland_reserve_8 = POI(
        name: "Sungei Buloh Wetland Reserve",
        desc: "Singapore’s first ASEAN Heritage Park, home to diverse mangroves and migratory birds.",
        address: "301 Neo Tiew Cres, Singapore 718925",
        photoUrls: ["sungei-buloh-wetland-reserve_1", "sungei-buloh-wetland-reserve_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: lim_chu_kang,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.60, proximity: 0.20, pace: 0.95, mobility: 0.50, transport: 0.40, walkability: 0.50
        )
    )

    static let poi_east_coast_park_9 = POI(
        name: "East Coast Park",
        desc: "A scenic coastal park offering cycling, cable skiing, and a famous seafood center by the beach.",
        address: "E Coast Park Service Rd",
        photoUrls: ["east-coast-park_1", "east-coast-park_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: east_coast,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.45, pace: 0.90, mobility: 0.85, transport: 0.60, walkability: 0.90
        )
    )

    static let poi_ion_orchard_10 = POI(
        name: "Ion Orchard",
        desc: "A futuristic premier mall featuring high-end brands and the Ion Sky observation deck.",
        address: "2 Orchard Turn, Singapore 238801",
        photoUrls: ["ion-orchard_1", "ion-orchard_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: orchard_road,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.95, proximity: 0.90, pace: 0.30, mobility: 0.95, transport: 0.50, walkability: 0.50
        )
    )

    static let poi_mustafa_centre_11 = POI(
        name: "Mustafa Centre",
        desc: "A legendary 24-hour shopping mall in Little India that sells almost everything imaginable.",
        address: "145 Syed Alwi Rd, Singapore 207704",
        photoUrls: ["mustafa-centre_1", "mustafa-centre_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: little_india,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.75, pace: 0.10, mobility: 0.60, transport: 0.90, walkability: 0.80
        )
    )

    static let poi_bugis_junction_12 = POI(
        name: "Bugis Junction",
        desc: "A vibrant shopping destination featuring a mix of modern mall space and air-conditioned shophouses.",
        address: "200 Victoria St, Singapore 188021",
        photoUrls: ["bugis-junction_1", "bugis-junction_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: bugis,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.85, pace: 0.30, mobility: 0.95, transport: 0.50, walkability: 0.50
        )
    )

    static let poi_wings_of_time_13 = POI(
        name: "Wings of Time",
        desc: "A stunning outdoor night show featuring water, laser, and fire effects set against the sea.",
        address: "50 Beach View, Sentosa",
        photoUrls: ["wings-of-time_1", "wings-of-time_2"],
        openTime: "19:40",
        closeTime: "21:00",
        district: sentosa_island,
        categories: [categories[24], entertainment, nature],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.40, pace: 0.60, mobility: 0.90, transport: 0.75, walkability: 0.85
        )
    )

    static let poi_duck_tours_14 = POI(
        name: "Duck Tours",
        desc: "An amphibious tour vehicle that travels on both land and water to see Singapore’s landmarks.",
        address: "3 Temasek Blvd, Suntec City",
        photoUrls: ["duck-tours_1", "duck-tours_2"],
        openTime: "09:00",
        closeTime: "18:30",
        district: downtown,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.90, pace: 0.70, mobility: 0.80, transport: 0.95, walkability: 0.90
        )
    )

    static let poi_the_hive_15 = POI(
        name: "The Hive",
        desc: "Award-winning architectural marvel at Nanyang Technological University.",
        address: "52 Nanyang Ave",
        photoUrls: ["the-hive_1", "the-hive_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: jurong,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.25, pace: 0.80, mobility: 0.85, transport: 0.50, walkability: 0.80
        )
    )

    static let poi_marina_barrage_16 = POI(
        name: "Marina Barrage",
        desc: "A dam and rooftop park for picnics and kite-flying.",
        address: "8 Marina Gardens Dr, S018951",
        photoUrls: ["marina-barrage_1", "marina-barrage_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: marina_south,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.85, pace: 0.95, mobility: 0.95, transport: 0.75, walkability: 0.90
        )
    )

    static let poi_science_centre_17 = POI(
        name: "Science Centre",
        desc: "Interactive science exhibits and educational galleries.",
        address: "15 Science Centre Rd",
        photoUrls: ["science-centre_1", "science-centre_2"],
        openTime: "10:00",
        closeTime: "17:00",
        district: jurong,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.55, pace: 0.50, mobility: 0.90, transport: 0.90, walkability: 0.90
        )
    )

    static let poi_bukit_timah_nature_reserve_18 = POI(
        name: "Bukit Timah Nature Reserve",
        desc: "A large nature reserve featuring Singapore's highest hill.",
        address: "Hindhede Dr, S589318",
        photoUrls: ["bukit-timah-nature-reserve_1", "bukit-timah-nature-reserve_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: bukit_timah,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.45, pace: 0.80, mobility: 0.30, transport: 0.65, walkability: 0.40
        )
    )

    static let poi_punggol_waterway_park_19 = POI(
        name: "Punggol Waterway Park",
        desc: "A scenic riverside park with cycling and jogging tracks.",
        address: "Sentul Cres, S821313",
        photoUrls: ["punggol-waterway-park_1", "punggol-waterway-park_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: punggol,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.65, proximity: 0.30, pace: 0.90, mobility: 0.90, transport: 0.70, walkability: 0.90
        )
    )

    static let poi_victoria_theatre_20 = POI(
        name: "Victoria Theatre",
        desc: "A historic concert hall and performing arts venue.",
        address: "11 Empress Pl",
        photoUrls: ["victoria-theatre_1", "victoria-theatre_2"],
        openTime: "10:00",
        closeTime: "21:00",
        district: central,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.90, pace: 0.80, mobility: 0.90, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_spectra_light___water_show_21 = POI(
        name: "Spectra Light & Water Show",
        desc: "A spectacular outdoor light and water show over the bay.",
        address: "10 Bayfront Ave, S018956",
        photoUrls: ["spectra-light-water-show_1", "spectra-light-water-show_2"],
        openTime: "08:00",
        closeTime: "09:00",
        district: marina_bay,
        categories: [categories[24], entertainment, nature],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.95, pace: 0.60, mobility: 0.95, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_the_intan_22 = POI(
        name: "The Intan",
        desc: "A private home-museum dedicated to Peranakan culture.",
        address: "69 Joo Chiat Terrace, S427231",
        photoUrls: ["the-intan_1", "the-intan_2"],
        openTime: "07:00",
        closeTime: "22:00",
        district: east_coast,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.55, proximity: 0.45, pace: 0.85, mobility: 0.60, transport: 0.60, walkability: 0.75
        )
    )

    static let poi_snow_city_23 = POI(
        name: "Snow City",
        desc: "Singapore's first indoor snow center for winter activities.",
        address: "21 Jurong Town Hall Rd",
        photoUrls: ["snow-city_1", "snow-city_2"],
        openTime: "10:00",
        closeTime: "17:00",
        district: jurong,
        categories: [metro, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.55, pace: 0.40, mobility: 0.85, transport: 0.90, walkability: 0.90
        )
    )

    static let poi_chinese_garden_24 = POI(
        name: "Chinese Garden",
        desc: "Public park featuring traditional Chinese architectural styles.",
        address: "1 Chinese Garden Rd",
        photoUrls: ["chinese-garden_1", "chinese-garden_2"],
        openTime: "06:00",
        closeTime: "23:00",
        district: jurong,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.50, pace: 0.90, mobility: 0.80, transport: 0.85, walkability: 0.85
        )
    )

    static let poi_gardens_by_the_bay_25 = POI(
        name: "Gardens by the Bay",
        desc: "Futuristic nature park featuring Supertree Grove and Cloud Forest.",
        address: "18 Marina Gardens Dr",
        photoUrls: ["gardens-by-the-bay_1", "gardens-by-the-bay_2"],
        openTime: "05:00",
        closeTime: "02:00",
        district: marina_south,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.95, proximity: 0.85, pace: 0.40, mobility: 0.90, transport: 0.90, walkability: 0.80
        )
    )

    static let poi_buddha_tooth_relic_26 = POI(
        name: "Buddha Tooth Relic",
        desc: "Magnificent Tang-style temple housing a sacred Buddha relic.",
        address: "288 South Bridge Rd",
        photoUrls: ["buddha-tooth-relic_1", "buddha-tooth-relic_2"],
        openTime: "07:00",
        closeTime: "17:00",
        district: chinatown,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.90, pace: 0.30, mobility: 0.80, transport: 0.95, walkability: 0.90
        )
    )

    static let poi_marina_bay_sands_27 = POI(
        name: "Marina Bay Sands",
        desc: "Iconic hotel featuring a boat-shaped rooftop and infinity pool.",
        address: "10 Bayfront Ave",
        photoUrls: ["marina-bay-sands_1", "marina-bay-sands_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: marina_south,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.98, proximity: 0.80, pace: 0.50, mobility: 0.85, transport: 0.90, walkability: 0.70
        )
    )

    static let poi_merlion_park_28 = POI(
        name: "Merlion Park",
        desc: "Home to the iconic statue of Singapore's national emblem.",
        address: "Fullerton Rd",
        photoUrls: ["merlion-park_1", "merlion-park_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: marina_bay,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.99, proximity: 0.95, pace: 0.40, mobility: 0.90, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_universal_studios_29 = POI(
        name: "Universal Studios",
        desc: "Movie-themed park with world-class rides and entertainment.",
        address: "8 Sentosa Gateway",
        photoUrls: ["universal-studios_1", "universal-studios_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: sentosa_island,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.92, proximity: 0.50, pace: 0.90, mobility: 0.70, transport: 0.80, walkability: 0.60
        )
    )

    static let poi_jewel_changi_airport_30 = POI(
        name: "Jewel Changi Airport",
        desc: "A nature-themed retail and entertainment complex with a vortex.",
        address: "78 Airport Blvd, S819666",
        photoUrls: ["jewel-changi-airport_1", "jewel-changi-airport_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: changi,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.97, proximity: 0.10, pace: 0.50, mobility: 0.95, transport: 0.99, walkability: 0.85
        )
    )

    static let poi_clarke_quay_31 = POI(
        name: "Clarke Quay",
        desc: "A historical riverside quay famous for nightlife and dining.",
        address: "3 River Valley Rd, S179024",
        photoUrls: ["clarke-quay_1", "clarke-quay_2"],
        openTime: "10:00",
        closeTime: "23:00",
        district: river_valley,
        categories: [categories[24], entertainment, nature],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.90, pace: 0.70, mobility: 0.80, transport: 0.95, walkability: 0.90
        )
    )

    static let poi_botanic_gardens_32 = POI(
        name: "Botanic Gardens",
        desc: "A 161-year-old tropical garden and UNESCO World Heritage site.",
        address: "1 Cluny Rd, S259569",
        photoUrls: ["botanic-gardens_1", "botanic-gardens_2"],
        openTime: "05:00",
        closeTime: "12:00",
        district: central,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.60, pace: 0.20, mobility: 0.90, transport: 0.85, walkability: 0.85
        )
    )

    static let poi_chinatown_market_33 = POI(
        name: "Chinatown Market",
        desc: "A bustling street market selling souvenirs and local snacks.",
        address: "Trengganu St, S050005",
        photoUrls: ["chinatown-market_1", "chinatown-market_2"],
        openTime: "11:00",
        closeTime: "21:00",
        district: chinatown,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.92, pace: 0.60, mobility: 0.70, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_little_india_34 = POI(
        name: "Little India",
        desc: "A vibrant ethnic district with colorful shops and temples.",
        address: "Serangoon Rd, S218086",
        photoUrls: ["little-india_1", "little-india_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: little_india,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.85, pace: 0.70, mobility: 0.60, transport: 0.90, walkability: 0.90
        )
    )

    static let poi_artscience_museum_35 = POI(
        name: "ArtScience Museum",
        desc: "Lotus-inspired museum featuring immersive digital art exhibitions.",
        address: "6 Bayfront Ave",
        photoUrls: ["artscience-museum_1", "artscience-museum_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: marina_bay,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.85, pace: 0.40, mobility: 0.90, transport: 0.90, walkability: 0.80
        )
    )

    static let poi_national_gallery_36 = POI(
        name: "National Gallery",
        desc: "Singapore’s largest public art gallery housed in the former City Hall.",
        address: "1 St Andrew’s Rd",
        photoUrls: ["national-gallery_1", "national-gallery_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: civic_district,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.90, pace: 0.30, mobility: 0.90, transport: 0.95, walkability: 0.90
        )
    )

    static let poi_night_safari_37 = POI(
        name: "Night Safari",
        desc: "The world's first nocturnal wildlife park.",
        address: "80 Mandai Lake Rd",
        photoUrls: ["night-safari_1", "night-safari_2"],
        openTime: "18:30",
        closeTime: "00:00",
        district: mandai,
        categories: [categories[2], nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.89, proximity: 0.20, pace: 0.60, mobility: 0.60, transport: 0.60, walkability: 0.40
        )
    )

    static let poi_haji_lane_38 = POI(
        name: "Haji Lane",
        desc: "Narrow alleyway famous for colorful murals and indie boutiques.",
        address: "Haji Lane",
        photoUrls: ["haji-lane_1", "haji-lane_2"],
        openTime: "11:00",
        closeTime: "22:00",
        district: kampong_glam,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.84, proximity: 0.88, pace: 0.50, mobility: 0.70, transport: 0.90, walkability: 0.95
        )
    )

    static let poi_singapore_flyer_39 = POI(
        name: "Singapore Flyer",
        desc: "A giant observation wheel offering panoramic city views.",
        address: "30 Raffles Ave, S039803",
        photoUrls: ["singapore-flyer_1", "singapore-flyer_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: marina_bay,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.78, proximity: 0.80, pace: 0.40, mobility: 0.80, transport: 0.85, walkability: 0.75
        )
    )

    static let poi_sentosa_luge_40 = POI(
        name: "Sentosa Luge",
        desc: "A thrilling gravity-fueled ride on a specialized cart.",
        address: "45 Siloso Beach Walk",
        photoUrls: ["sentosa-luge_1", "sentosa-luge_2"],
        openTime: "11:00",
        closeTime: "19:30",
        district: sentosa_island,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.83, proximity: 0.45, pace: 0.80, mobility: 0.70, transport: 0.75, walkability: 0.60
        )
    )

    static let poi_lau_pa_sat_41 = POI(
        name: "Lau Pa Sat",
        desc: "Historic octagonal market turned gourmet food court.",
        address: "18 Raffles Quay",
        photoUrls: ["lau-pa-sat_1", "lau-pa-sat_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: downtown,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.95, pace: 0.80, mobility: 0.85, transport: 0.98, walkability: 0.95
        )
    )

    static let poi_henderson_waves_42 = POI(
        name: "Henderson Waves",
        desc: "Singapore's highest pedestrian bridge with a wave-like form.",
        address: "Henderson Rd, S159557",
        photoUrls: ["henderson-waves_1", "henderson-waves_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: bukit_merah,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.65, proximity: 0.40, pace: 0.30, mobility: 0.50, transport: 0.60, walkability: 0.70
        )
    )

    static let poi_s_e_a__aquarium_43 = POI(
        name: "S.E.A. Aquarium",
        desc: "One of the world’s largest aquariums with over 100,000 marine animals.",
        address: "8 Sentosa Gateway",
        photoUrls: ["s-e-a-aquarium_1", "s-e-a-aquarium_2"],
        openTime: "10:00",
        closeTime: "17:00",
        district: sentosa_island,
        categories: [categories[2], nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.48, pace: 0.50, mobility: 0.80, transport: 0.80, walkability: 0.60
        )
    )

    static let poi_orchard_road_44 = POI(
        name: "Orchard Road",
        desc: "A world-renowned shopping street with numerous malls.",
        address: "Orchard Road, S238865",
        photoUrls: ["orchard-road_1", "orchard-road_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: orchard_road,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.95, proximity: 0.90, pace: 0.70, mobility: 0.90, transport: 0.99, walkability: 0.98
        )
    )

    static let poi_fort_canning_park_45 = POI(
        name: "Fort Canning Park",
        desc: "A hilltop landmark full of historical military relics.",
        address: "Cox Terrace, S179618",
        photoUrls: ["fort-canning-park_1", "fort-canning-park_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: central,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.72, proximity: 0.85, pace: 0.30, mobility: 0.60, transport: 0.90, walkability: 0.80
        )
    )

    static let poi_asian_civ_museum_46 = POI(
        name: "Asian Civ Museum",
        desc: "A museum exploring the artistic heritage of Asia.",
        address: "1 Empress Pl, S179555",
        photoUrls: ["asian-civ-museum_1", "asian-civ-museum_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: civic_district,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.60, proximity: 0.92, pace: 0.30, mobility: 0.90, transport: 0.95, walkability: 0.90
        )
    )

    static let poi_esplanade_47 = POI(
        name: "Esplanade",
        desc: "Performing arts center known for its unique durian-shaped architecture.",
        address: "1 Esplanade Dr",
        photoUrls: ["esplanade_1", "esplanade_2"],
        openTime: "10:00",
        closeTime: "21:00",
        district: downtown,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.76, proximity: 0.90, pace: 0.40, mobility: 0.90, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_mount_faber_park_48 = POI(
        name: "Mount Faber Park",
        desc: "A hilltop park offering views and cable car rides.",
        address: "Junction of Kampong Bahru and Telok Blangah",
        photoUrls: ["mount-faber-park_1", "mount-faber-park_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: harbourfront,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.55, proximity: 0.35, pace: 0.40, mobility: 0.40, transport: 0.50, walkability: 0.50
        )
    )

    static let poi_national_museum_49 = POI(
        name: "National Museum",
        desc: "The oldest museum in Singapore focused on local history.",
        address: "93 Stamford Rd, S178897",
        photoUrls: ["national-museum_1", "national-museum_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: civic_district,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.68, proximity: 0.88, pace: 0.30, mobility: 0.90, transport: 0.95, walkability: 0.90
        )
    )

    static let poi_river_wonders_50 = POI(
        name: "River Wonders",
        desc: "Asia's first and only river-themed wildlife park.",
        address: "80 Mandai Lake Rd",
        photoUrls: ["river-wonders_1", "river-wonders_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: mandai,
        categories: [categories[2], nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.81, proximity: 0.20, pace: 0.50, mobility: 0.80, transport: 0.60, walkability: 0.50
        )
    )

    static let poi_tiong_bahru_51 = POI(
        name: "Tiong Bahru",
        desc: "A charming heritage estate with cafes and art deco buildings.",
        address: "52 Tiong Bahru Rd, S168716",
        photoUrls: ["tiong-bahru_1", "tiong-bahru_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: bukit_merah,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.62, proximity: 0.65, pace: 0.40, mobility: 0.70, transport: 0.85, walkability: 0.85
        )
    )

    static let poi_suntec_fountain_52 = POI(
        name: "Suntec Fountain",
        desc: "A large bronze fountain symbolizing wealth and prosperity.",
        address: "3 Temasek Blvd, S038983",
        photoUrls: ["suntec-fountain_1", "suntec-fountain_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: downtown,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.85, pace: 0.40, mobility: 0.90, transport: 0.98, walkability: 0.90
        )
    )

    static let poi_palawan_beach_53 = POI(
        name: "Palawan Beach",
        desc: "A family-friendly beach with a suspension bridge.",
        address: "Palawan Beach, Sentosa Island",
        photoUrls: ["palawan-beach_1", "palawan-beach_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: sentosa_island,
        categories: [categories[17], nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.74, proximity: 0.40, pace: 0.20, mobility: 0.70, transport: 0.70, walkability: 0.75
        )
    )

    static let poi_bird_paradise_54 = POI(
        name: "Bird Paradise",
        desc: "Modern bird park with massive walk-through aviaries.",
        address: "20 Mandai Lake Rd",
        photoUrls: ["bird-paradise_1", "bird-paradise_2"],
        openTime: "09:00",
        closeTime: "18:00",
        district: mandai,
        categories: [categories[2], nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.15, pace: 0.60, mobility: 0.75, transport: 0.60, walkability: 0.55
        )
    )

    static let poi_singapore_zoo_55 = POI(
        name: "Singapore Zoo",
        desc: "An award-winning wildlife park with an open-concept habitat.",
        address: "80 Mandai Lake Rd, S729826",
        photoUrls: ["singapore-zoo_1", "singapore-zoo_2"],
        openTime: "08:30",
        closeTime: "18:00",
        district: mandai,
        categories: [categories[2], nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.93, proximity: 0.18, pace: 0.70, mobility: 0.80, transport: 0.60, walkability: 0.50
        )
    )

    static let poi_macritchie_56 = POI(
        name: "MacRitchie",
        desc: "A gateway to Singapore’s nature reserves and treetop walks.",
        address: "Lornie Rd, S298735",
        photoUrls: ["macritchie_1", "macritchie_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: central,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.60, proximity: 0.40, pace: 0.60, mobility: 0.40, transport: 0.60, walkability: 0.60
        )
    )

    static let poi_helix_bridge_57 = POI(
        name: "Helix Bridge",
        desc: "A pedestrian bridge with a unique double-helix structure.",
        address: "Linking Marina Bay to Marina Centre",
        photoUrls: ["helix-bridge_1", "helix-bridge_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: marina_bay,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.90, pace: 0.30, mobility: 0.95, transport: 0.95, walkability: 0.98
        )
    )

    static let poi_peranakan_museum_58 = POI(
        name: "Peranakan Museum",
        desc: "A museum showcasing the rich culture of Peranakan communities.",
        address: "39 Armenian St, S179941",
        photoUrls: ["peranakan-museum_1", "peranakan-museum_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: civic_district,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.63, proximity: 0.88, pace: 0.30, mobility: 0.90, transport: 0.95, walkability: 0.90
        )
    )

    static let poi_sri_mariamman_59 = POI(
        name: "Sri Mariamman",
        desc: "The oldest Hindu temple in Singapore with an ornate tower.",
        address: "244 South Bridge Rd, S058793",
        photoUrls: ["sri-mariamman_1", "sri-mariamman_2"],
        openTime: "6:00 ",
        closeTime: "18:00",
        district: chinatown,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.72, proximity: 0.92, pace: 0.30, mobility: 0.80, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_sultan_mosque_60 = POI(
        name: "Sultan Mosque",
        desc: "Prominent mosque with massive golden domes in Kampong Glam.",
        address: "3 Muscat St",
        photoUrls: ["sultan-mosque_1", "sultan-mosque_2"],
        openTime: "09:30",
        closeTime: "16:00",
        district: kampong_glam,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.88, pace: 0.30, mobility: 0.80, transport: 0.90, walkability: 0.95
        )
    )

    static let poi_adventure_cove_61 = POI(
        name: "Adventure Cove",
        desc: "A water theme park with high-speed slides and marine life.",
        address: "8 Sentosa Gateway, S098269",
        photoUrls: ["adventure-cove_1", "adventure-cove_2"],
        openTime: "10:00",
        closeTime: "17:00",
        district: sentosa_island,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.78, proximity: 0.45, pace: 0.90, mobility: 0.65, transport: 0.75, walkability: 0.50
        )
    )

    static let poi_emerald_hill_62 = POI(
        name: "Emerald Hill",
        desc: "A historic neighborhood with colorful Peranakan-style houses.",
        address: "Emerald Hill Rd (near Orchard)",
        photoUrls: ["emerald-hill_1", "emerald-hill_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: orchard_road,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.58, proximity: 0.90, pace: 0.30, mobility: 0.70, transport: 0.99, walkability: 0.95
        )
    )

    static let poi_library_orchard_63 = POI(
        name: "Library@Orchard",
        desc: "A stylish public library with a focus on design and arts.",
        address: "277 Orchard Rd, #03-12, S238858",
        photoUrls: ["library-orchard_1", "library-orchard_2"],
        openTime: "11:00",
        closeTime: "21:00",
        district: orchard_road,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.92, pace: 0.20, mobility: 0.95, transport: 0.99, walkability: 0.98
        )
    )

    static let poi_old_hill_police_stn_64 = POI(
        name: "Old Hill Police Stn",
        desc: "Historical building famous for its 927 rainbow-colored windows.",
        address: "140 Hill St",
        photoUrls: ["old-hill-police-stn_1", "old-hill-police-stn_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: civic_district,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.90, pace: 0.20, mobility: 0.90, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_siloso_beach_65 = POI(
        name: "Siloso Beach",
        desc: "Popular sandy beach with bars, restaurants, and water sports.",
        address: "Siloso Beach Walk",
        photoUrls: ["siloso-beach_1", "siloso-beach_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: sentosa_island,
        categories: [categories[17], nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.79, proximity: 0.38, pace: 0.40, mobility: 0.75, transport: 0.70, walkability: 0.70
        )
    )

    static let poi_madame_tussauds_66 = POI(
        name: "Madame Tussauds",
        desc: "Famous wax museum featuring lifelike figures of celebrities.",
        address: "40 Imbiah Rd, S099700",
        photoUrls: ["madame-tussauds_1", "madame-tussauds_2"],
        openTime: "10:00",
        closeTime: "18:00",
        district: sentosa_island,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.45, pace: 0.60, mobility: 0.85, transport: 0.75, walkability: 0.60
        )
    )

    static let poi_vivocity_sky_park_67 = POI(
        name: "VivoCity Sky Park",
        desc: "A large rooftop space with a water feature and sea views.",
        address: "1 HarbourFront Walk, S098585",
        photoUrls: ["vivocity-sky-park_1", "vivocity-sky-park_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: harbourfront,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.75, pace: 0.40, mobility: 0.95, transport: 0.99, walkability: 0.90
        )
    )

    static let poi_jurong_lake_garden_68 = POI(
        name: "Jurong Lake Garden",
        desc: "A sprawling lakeside park with nature play and scenic views.",
        address: "Yuan Ching Rd, S619316",
        photoUrls: ["jurong-lake-garden_1", "jurong-lake-garden_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: jurong,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.68, proximity: 0.25, pace: 0.30, mobility: 0.85, transport: 0.80, walkability: 0.85
        )
    )

    static let poi_maxwell_food_ctr_69 = POI(
        name: "Maxwell Food Ctr",
        desc: "Legendary hawker centre famous for Hainanese Chicken Rice.",
        address: "1 Kadayanallur St",
        photoUrls: ["maxwell-food-ctr_1", "maxwell-food-ctr_2"],
        openTime: "08:00",
        closeTime: "22:00",
        district: chinatown,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.92, proximity: 0.95, pace: 0.80, mobility: 0.85, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_skyhelix_sentosa_70 = POI(
        name: "SkyHelix Sentosa",
        desc: "Highest open-air panoramic ride in Singapore.",
        address: "41 imbiah Rd",
        photoUrls: ["skyhelix-sentosa_1", "skyhelix-sentosa_2"],
        openTime: "10:00",
        closeTime: "21:30",
        district: sentosa_island,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.45, pace: 0.30, mobility: 0.85, transport: 0.80, walkability: 0.80
        )
    )

    static let poi_plaza_singapura_71 = POI(
        name: "Plaza Singapura",
        desc: "A popular contemporary shopping mall on Orchard Road.",
        address: "68 Orchard Rd, S238839",
        photoUrls: ["plaza-singapura_1", "plaza-singapura_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: orchard_road,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.85, pace: 0.60, mobility: 0.95, transport: 0.98, walkability: 0.95
        )
    )

    static let poi_pulau_ubin_72 = POI(
        name: "Pulau Ubin",
        desc: "An island sanctuary with a rustic, old-Singapore vibe.",
        address: "Pulau Ubin (via Changi Point Ferry)",
        photoUrls: ["pulau-ubin_1", "pulau-ubin_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: changi,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.10, pace: 0.30, mobility: 0.30, transport: 0.40, walkability: 0.50
        )
    )

    static let poi_arab_street_73 = POI(
        name: "Arab Street",
        desc: "A historic area known for textiles, cafes, and heritage.",
        address: "Arab Street, S199745",
        photoUrls: ["arab-street_1", "arab-street_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: kampong_glam,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.88, pace: 0.60, mobility: 0.80, transport: 0.90, walkability: 0.90
        )
    )

    static let poi_tekka_centre_74 = POI(
        name: "Tekka Centre",
        desc: "A vibrant market and food centre in Little India.",
        address: "665 Buffalo Rd, S210665",
        photoUrls: ["tekka-centre_1", "tekka-centre_2"],
        openTime: "06:30",
        closeTime: "21:00",
        district: little_india,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.85, pace: 0.90, mobility: 0.75, transport: 0.95, walkability: 0.85
        )
    )

    static let poi_rail_corridor_75 = POI(
        name: "Rail Corridor",
        desc: "A former railway line converted into a scenic nature trail.",
        address: "Various entry points (e.g., Bukit Timah)",
        photoUrls: ["rail-corridor_1", "rail-corridor_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: bukit_timah,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.50, pace: 0.40, mobility: 0.60, transport: 0.70, walkability: 0.80
        )
    )

    static let poi_singapore_cable_car_76 = POI(
        name: "Singapore Cable Car",
        desc: "Gondola lift providing aerial views of the city and Sentosa.",
        address: "109 Mount Faber Rd, S099203",
        photoUrls: ["singapore-cable-car_1", "singapore-cable-car_2"],
        openTime: "08:45",
        closeTime: "22:00",
        district: harbourfront,
        categories: [categories[5], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.70, pace: 0.30, mobility: 0.85, transport: 0.90, walkability: 0.80
        )
    )

    static let poi_tanjong_beach_77 = POI(
        name: "Tanjong Beach",
        desc: "A serene and relaxing beach spot on Sentosa Island.",
        address: "120 Tanjong Beach Walk, S098942",
        photoUrls: ["tanjong-beach_1", "tanjong-beach_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: sentosa_island,
        categories: [categories[17], nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.72, proximity: 0.38, pace: 0.20, mobility: 0.70, transport: 0.65, walkability: 0.75
        )
    )

    static let poi_mint_museum_of_toys_78 = POI(
        name: "Mint Museum of Toys",
        desc: "A private museum with a world-class collection of vintage toys.",
        address: "26 Seah St, S188382",
        photoUrls: ["mint-museum-of-toys_1", "mint-museum-of-toys_2"],
        openTime: "09:30",
        closeTime: "18:30",
        district: civic_district,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.60, proximity: 0.90, pace: 0.30, mobility: 0.85, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_fort_siloso_79 = POI(
        name: "Fort Siloso",
        desc: "Singapore’s only preserved coastal gun battery and museum.",
        address: "Siloso Rd, S099981",
        photoUrls: ["fort-siloso_1", "fort-siloso_2"],
        openTime: "10:00",
        closeTime: "18:00",
        district: sentosa_island,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.68, proximity: 0.40, pace: 0.40, mobility: 0.65, transport: 0.70, walkability: 0.65
        )
    )

    static let poi_chomp_chomp_food_centre_80 = POI(
        name: "Chomp Chomp Food Centre",
        desc: "A famous local spot for late-night satay and BBQ seafood.",
        address: "20 Kensington Park Rd, S557269",
        photoUrls: ["chomp-chomp-food-centre_1", "chomp-chomp-food-centre_2"],
        openTime: "16:00",
        closeTime: "00:30",
        district: little_india,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.50, pace: 0.80, mobility: 0.70, transport: 0.65, walkability: 0.75
        )
    )

    static let poi_changi_chapel___museum_81 = POI(
        name: "Changi Chapel & Museum",
        desc: "A site dedicated to the history of POWs during WWII.",
        address: "1000 Upper Changi Rd N, S507707",
        photoUrls: ["changi-chapel-museum_1", "changi-chapel-museum_2"],
        openTime: "09:30",
        closeTime: "17:30",
        district: changi,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.60, proximity: 0.15, pace: 0.20, mobility: 0.85, transport: 0.60, walkability: 0.80
        )
    )

    static let poi_coney_island_82 = POI(
        name: "Coney Island",
        desc: "An ecologically diverse park for cycling and bird watching.",
        address: "Punggol Promenade Nature Walk, S829325",
        photoUrls: ["coney-island_1", "coney-island_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: punggol,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.65, proximity: 0.25, pace: 0.40, mobility: 0.50, transport: 0.65, walkability: 0.70
        )
    )

    static let poi_malay_heritage_centre_83 = POI(
        name: "Malay Heritage Centre",
        desc: "A museum exploring the history and culture of Malay locals.",
        address: "85 Sultan Gate, S198501",
        photoUrls: ["malay-heritage-centre_1", "malay-heritage-centre_2"],
        openTime: "10:00",
        closeTime: "18:00",
        district: kampong_glam,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.88, pace: 0.30, mobility: 0.85, transport: 0.90, walkability: 0.95
        )
    )

    static let poi_trick_eye_museum_84 = POI(
        name: "Trick Eye Museum",
        desc: "An interactive 3D museum with optical illusion artworks.",
        address: "80 Siloso Rd, S098969",
        photoUrls: ["trick-eye-museum_1", "trick-eye-museum_2"],
        openTime: "11:00",
        closeTime: "19:00",
        district: sentosa_island,
        categories: [categories[4], culture, nature],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.45, pace: 0.60, mobility: 0.85, transport: 0.75, walkability: 0.80
        )
    )

    static let poi_east_coast_lagoon_food_village_85 = POI(
        name: "East Coast Lagoon Food Village",
        desc: "An iconic beachfront food centre for seafood and satay.",
        address: "1220 ECP, S468960",
        photoUrls: ["east-coast-lagoon-food-village_1", "east-coast-lagoon-food-village_2"],
        openTime: "16:00",
        closeTime: "22:30",
        district: east_coast,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.45, pace: 0.75, mobility: 0.80, transport: 0.60, walkability: 0.85
        )
    )

    static let poi_dempsey_hill_86 = POI(
        name: "Dempsey Hill",
        desc: "A dining and lifestyle destination in lush greenery.",
        address: "Dempsey Rd, S249679",
        photoUrls: ["dempsey-hill_1", "dempsey-hill_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: central,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.78, proximity: 0.65, pace: 0.40, mobility: 0.85, transport: 0.60, walkability: 0.85
        )
    )

    static let poi_funan_mall_87 = POI(
        name: "Funan Mall",
        desc: "A tech-focused lifestyle mall with an indoor cycling track.",
        address: "107 North Bridge Rd",
        photoUrls: ["funan-mall_1", "funan-mall_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: civic_district,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.92, pace: 0.60, mobility: 0.95, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_battlebox_88 = POI(
        name: "Battlebox",
        desc: "WWII British underground command centre inside Fort Canning Hill.",
        address: "2 Cox Terrace, S179622",
        photoUrls: ["battlebox_1", "battlebox_2"],
        openTime: "09:30",
        closeTime: "17:30",
        district: civic_district,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.85, pace: 0.40, mobility: 0.60, transport: 0.90, walkability: 0.85
        )
    )

    static let poi_national_design_centre_89 = POI(
        name: "National Design Centre",
        desc: "A hub for design excellence and exhibitions.",
        address: "111 Middle Rd, S188969",
        photoUrls: ["national-design-centre_1", "national-design-centre_2"],
        openTime: "09:00",
        closeTime: "21:00",
        district: bugis,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.65, proximity: 0.90, pace: 0.40, mobility: 0.90, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_istana_heritage_gallery_90 = POI(
        name: "Istana Heritage Gallery",
        desc: "History and heritage of the President's office.",
        address: "35 Orchard Rd, S238823",
        photoUrls: ["istana-heritage-gallery_1", "istana-heritage-gallery_2"],
        openTime: "10:00",
        closeTime: "18:00",
        district: orchard_road,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.90, pace: 0.35, mobility: 0.90, transport: 1.00, walkability: 1.00
        )
    )

    static let poi_armenian_church_91 = POI(
        name: "Armenian Church",
        desc: "The oldest Christian church in Singapore, built in 1835.",
        address: "60 Hill St, S179366",
        photoUrls: ["armenian-church_1", "armenian-church_2"],
        openTime: "09:00",
        closeTime: "18:00",
        district: civic_district,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.60, proximity: 0.90, pace: 0.30, mobility: 0.85, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_hortpark_92 = POI(
        name: "HortPark",
        desc: "A gardening resource hub with themed gardens.",
        address: "33 Hyderabad Rd, S119578",
        photoUrls: ["hortpark_1", "hortpark_2"],
        openTime: "06:00",
        closeTime: "23:00",
        district: bukit_merah,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.60, pace: 0.85, mobility: 0.80, transport: 0.70, walkability: 0.85
        )
    )

    static let poi_woodlands_waterfront_jetty_93 = POI(
        name: "Woodlands Waterfront Jetty",
        desc: "Long jetty with views of the Johor Strait.",
        address: "Admiralty Rd West",
        photoUrls: ["woodlands-waterfront-jetty_1", "woodlands-waterfront-jetty_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: lim_chu_kang,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.20, pace: 0.80, mobility: 0.85, transport: 0.50, walkability: 0.80
        )
    )

    static let poi_lower_peirce_reservoir_94 = POI(
        name: "Lower Peirce Reservoir",
        desc: "Scenic reservoir with a boardwalk through forest.",
        address: "Old Upper Thomson Rd",
        photoUrls: ["lower-peirce-reservoir_1", "lower-peirce-reservoir_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: mandai,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.45, pace: 0.85, mobility: 0.75, transport: 0.60, walkability: 0.70
        )
    )

    static let poi_upper_seletar_reservoir_95 = POI(
        name: "Upper Seletar Reservoir",
        desc: "Iconic rocket lookout tower and lake views.",
        address: "Mandai Rd Track 7",
        photoUrls: ["upper-seletar-reservoir_1", "upper-seletar-reservoir_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: mandai,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.72, proximity: 0.35, pace: 0.80, mobility: 0.70, transport: 0.55, walkability: 0.65
        )
    )

    static let poi_chesnut_nature_park_96 = POI(
        name: "Chesnut Nature Park",
        desc: "Largest nature park with mountain biking trails.",
        address: "Chestnut Ave",
        photoUrls: ["chesnut-nature-park_1", "chesnut-nature-park_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: bukit_timah,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.65, proximity: 0.40, pace: 0.95, mobility: 0.60, transport: 0.50, walkability: 0.60
        )
    )

    static let poi_labrador_nature_reserve_97 = POI(
        name: "Labrador Nature Reserve",
        desc: "Coastal park featuring WWII relics.",
        address: "Labrador Villa Rd",
        photoUrls: ["labrador-nature-reserve_1", "labrador-nature-reserve_2"],
        openTime: "07:00",
        closeTime: "19:00",
        district: harbourfront,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.78, proximity: 0.65, pace: 0.80, mobility: 0.80, transport: 0.75, walkability: 0.85
        )
    )

    static let poi_pasir_ris_park_98 = POI(
        name: "Pasir Ris Park",
        desc: "Large coastal park with a mangrove boardwalk.",
        address: "Pasir Ris Rd",
        photoUrls: ["pasir-ris-park_1", "pasir-ris-park_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: east_coast,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.35, pace: 0.85, mobility: 0.85, transport: 0.70, walkability: 0.85
        )
    )

    static let poi_hydrodash_99 = POI(
        name: "HydroDash",
        desc: "Floating aqua park with obstacle courses.",
        address: "Palawan Beach, Sentosa",
        photoUrls: ["hydrodash_1", "hydrodash_2"],
        openTime: "12:00",
        closeTime: "18:00",
        district: sentosa_island,
        categories: [entertainment, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.50, pace: 0.90, mobility: 0.60, transport: 0.70, walkability: 0.80
        )
    )

    static let poi_jewel_canopy_park_100 = POI(
        name: "Jewel Canopy Park",
        desc: "Play attractions like Petal Garden and Foggy Bowls.",
        address: "78 Airport Blvd, L5",
        photoUrls: ["jewel-canopy-park_1", "jewel-canopy-park_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: changi,
        categories: [kids, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.90, proximity: 0.15, pace: 0.70, mobility: 0.95, transport: 0.98, walkability: 1.00
        )
    )

    static let poi_changi_experience_studio_101 = POI(
        name: "Changi Experience Studio",
        desc: "Interactive attraction exploring airport operations.",
        address: "78 Airport Blvd, L4",
        photoUrls: ["changi-experience-studio_1", "changi-experience-studio_2"],
        openTime: "11:00",
        closeTime: "20:00",
        district: changi,
        categories: [kids, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.15, pace: 0.55, mobility: 0.95, transport: 0.98, walkability: 1.00
        )
    )

    static let poi_air_force_museum_102 = POI(
        name: "Air Force Museum",
        desc: "Displays heritage aircraft and RSAF history.",
        address: "400 Airport Rd, S534234",
        photoUrls: ["air-force-museum_1", "air-force-museum_2"],
        openTime: "09:00",
        closeTime: "16:00",
        district: changi,
        categories: [kids, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.65, proximity: 0.35, pace: 0.50, mobility: 0.80, transport: 0.55, walkability: 0.70
        )
    )

    static let poi_science_centre_singapore_103 = POI(
        name: "Science Centre Singapore",
        desc: "Over 1,000 interactive exhibits.",
        address: "15 Science Centre Rd",
        photoUrls: ["science-centre-singapore_1", "science-centre-singapore_2"],
        openTime: "10:00",
        closeTime: "17:00",
        district: jurong,
        categories: [kids, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.30, pace: 0.75, mobility: 0.90, transport: 0.80, walkability: 0.90
        )
    )

    static let poi_keppel_bay_104 = POI(
        name: "Keppel Bay",
        desc: "Luxury waterfront with stunning yacht views.",
        address: "Keppel Bay Vista",
        photoUrls: ["keppel-bay_1", "keppel-bay_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: harbourfront,
        categories: [metro, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.70, pace: 0.50, mobility: 0.90, transport: 0.80, walkability: 0.90
        )
    )

    static let poi_design_orchard_105 = POI(
        name: "Design Orchard",
        desc: "Showcases local Singaporean brands and designers.",
        address: "250 Orchard Rd, S238905",
        photoUrls: ["design-orchard_1", "design-orchard_2"],
        openTime: "10:30",
        closeTime: "21:30",
        district: orchard_road,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.72, proximity: 0.90, pace: 0.40, mobility: 0.95, transport: 1.00, walkability: 1.00
        )
    )

    static let poi_city_square_mall_106 = POI(
        name: "City Square Mall",
        desc: "First eco-mall with an integrated urban park.",
        address: "180 Kitchener Rd",
        photoUrls: ["city-square-mall_1", "city-square-mall_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: little_india,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.78, proximity: 0.85, pace: 0.45, mobility: 0.95, transport: 0.95, walkability: 1.00
        )
    )

    static let poi_millenia_walk_107 = POI(
        name: "Millenia Walk",
        desc: "Mall with unique architecture and design stores.",
        address: "9 Raffles Blvd, S039596",
        photoUrls: ["millenia-walk_1", "millenia-walk_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: downtown,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.68, proximity: 0.90, pace: 0.35, mobility: 0.95, transport: 0.95, walkability: 1.00
        )
    )

    static let poi_one_raffles_place_108 = POI(
        name: "One Raffles Place",
        desc: "Shopping and dining in the heart of the CBD.",
        address: "1 Raffles Pl, S048616",
        photoUrls: ["one-raffles-place_1", "one-raffles-place_2"],
        openTime: "10:00",
        closeTime: "21:00",
        district: downtown,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.92, pace: 0.40, mobility: 0.95, transport: 1.00, walkability: 1.00
        )
    )

    static let poi_zion_riverside_food_centre_109 = POI(
        name: "Zion Riverside Food Centre",
        desc: "Famous hawker centre known for Char Kway Teow.",
        address: "70 Zion Rd, S247792",
        photoUrls: ["zion-riverside-food-centre_1", "zion-riverside-food-centre_2"],
        openTime: "08:00",
        closeTime: "22:00",
        district: orchard_road,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.80, pace: 0.50, mobility: 0.80, transport: 0.85, walkability: 0.90
        )
    )

    static let poi_old_airport_road_food_centre_110 = POI(
        name: "Old Airport Road Food Centre",
        desc: "One of Singapore's best hawker centres.",
        address: "51 Old Airport Rd",
        photoUrls: ["old-airport-road-food-centre_1", "old-airport-road-food-centre_2"],
        openTime: "06:00",
        closeTime: "23:00",
        district: east_coast,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.70, pace: 0.60, mobility: 0.80, transport: 0.85, walkability: 0.90
        )
    )

    static let poi_satay_by_the_bay_111 = POI(
        name: "Satay by the Bay",
        desc: "Alfresco food court specializing in satay.",
        address: "18 Marina Gardens Dr",
        photoUrls: ["satay-by-the-bay_1", "satay-by-the-bay_2"],
        openTime: "11:00",
        closeTime: "22:00",
        district: marina_south,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.85, pace: 0.45, mobility: 0.90, transport: 0.75, walkability: 0.85
        )
    )

    static let poi_amoy_street_food_centre_112 = POI(
        name: "Amoy Street Food Centre",
        desc: "Popular CBD hub with Michelin stalls.",
        address: "7 Maxwell Rd, S069111",
        photoUrls: ["amoy-street-food-centre_1", "amoy-street-food-centre_2"],
        openTime: "06:30",
        closeTime: "21:00",
        district: chinatown,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.86, proximity: 0.90, pace: 0.70, mobility: 0.85, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_ghim_moh_market_113 = POI(
        name: "Ghim Moh Market",
        desc: "Traditional wet market and hawker center.",
        address: "20 Ghim Moh Rd",
        photoUrls: ["ghim-moh-market_1", "ghim-moh-market_2"],
        openTime: "06:00",
        closeTime: "22:00",
        district: bukit_timah,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.78, proximity: 0.55, pace: 0.65, mobility: 0.80, transport: 0.75, walkability: 0.85
        )
    )

    static let poi_bright_hill_temple_114 = POI(
        name: "Bright Hill Temple",
        desc: "One of the largest Buddhist temples in Singapore.",
        address: "88 Bright Hill Rd",
        photoUrls: ["bright-hill-temple_1", "bright-hill-temple_2"],
        openTime: "08:00",
        closeTime: "17:00",
        district: bukit_timah,
        categories: [supernatural, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.55, pace: 0.30, mobility: 0.80, transport: 0.70, walkability: 0.85
        )
    )

    static let poi_kwan_im_thong_hood_cho_115 = POI(
        name: "Kwan Im Thong Hood Cho",
        desc: "Famous temple for the Goddess of Mercy.",
        address: "178 Waterloo St",
        photoUrls: ["kwan-im-thong-hood-cho_1", "kwan-im-thong-hood-cho_2"],
        openTime: "07:00",
        closeTime: "18:00",
        district: bugis,
        categories: [supernatural, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.90, pace: 0.50, mobility: 0.85, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_sri_krishnan_temple_116 = POI(
        name: "Sri Krishnan Temple",
        desc: "Historic Hindu temple with a vibrant facade.",
        address: "152 Waterloo St",
        photoUrls: ["sri-krishnan-temple_1", "sri-krishnan-temple_2"],
        openTime: "06:00",
        closeTime: "21:00",
        district: bugis,
        categories: [supernatural, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.90, pace: 0.40, mobility: 0.85, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_maghain_aboth_synagogue_117 = POI(
        name: "Maghain Aboth Synagogue",
        desc: "The oldest synagogue in Southeast Asia.",
        address: "24 Waterloo St",
        photoUrls: ["maghain-aboth-synagogue_1", "maghain-aboth-synagogue_2"],
        openTime: "09:00",
        closeTime: "18:00",
        district: bugis,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.55, proximity: 0.90, pace: 0.35, mobility: 0.80, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_clarke_quay_118 = POI(
        name: "Clarke Quay",
        desc: "The main riverside hub for dining, bars, and nightlife.",
        address: "3 River Valley Rd, Singapore 179024",
        photoUrls: ["clarke-quay_1", "clarke-quay_2"],
        openTime: "12:00",
        closeTime: "02:00",
        district: river_valley,
        categories: [categories[24], entertainment, nature],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.80, pace: 0.50, mobility: 0.90, transport: 0.95, walkability: 0.90
        )
    )

    static let poi_asian_civilisations_museum_119 = POI(
        name: "Asian Civilisations Museum",
        desc: "Explores the artistic heritage of Asia along the Singapore River.",
        address: "1 Empress Pl, Singapore 179555",
        photoUrls: ["asian-civilisations-museum_1", "asian-civilisations-museum_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: civic_district,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.78, proximity: 0.85, pace: 0.30, mobility: 0.95, transport: 0.90, walkability: 0.50
        )
    )

    static let poi_bollywood_farms_120 = POI(
        name: "Bollywood Farms",
        desc: "A rustic organic farm and bistro offering farm-to-table dining and educational tours.",
        address: "100 Neo Tiew Rd, S719026",
        photoUrls: ["bollywood-farms_1", "bollywood-farms_2"],
        openTime: "07:00",
        closeTime: "17:00",
        district: lim_chu_kang,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.10, pace: 0.40, mobility: 0.70, transport: 0.30, walkability: 0.60
        )
    )

    static let poi_jurong_frog_farm_121 = POI(
        name: "Jurong Frog Farm",
        desc: "A unique heritage farm specializing in American Bullfrogs with tours and feeding sessions.",
        address: "56 Lim Chu Kang Lane 6, S719164",
        photoUrls: ["jurong-frog-farm_1", "jurong-frog-farm_2"],
        openTime: "09:00",
        closeTime: "17:30",
        district: lim_chu_kang,
        categories: [kids, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.65, proximity: 0.10, pace: 0.45, mobility: 0.75, transport: 0.30, walkability: 0.65
        )
    )

    static let poi_kranji_war_memorial_122 = POI(
        name: "Kranji War Memorial",
        desc: "A peaceful hillside memorial dedicated to those who died in the line of duty during WWII.",
        address: "9 Woodlands Rd, S738656",
        photoUrls: ["kranji-war-memorial_1", "kranji-war-memorial_2"],
        openTime: "08:00",
        closeTime: "18:30",
        district: lim_chu_kang,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.20, pace: 0.30, mobility: 0.65, transport: 0.50, walkability: 0.70
        )
    )

    static let poi_punggol_settlement_123 = POI(
        name: "Punggol Settlement",
        desc: "A scenic waterfront destination with a variety of seafood restaurants and bars.",
        address: "3 Punggol Point Rd",
        photoUrls: ["punggol-settlement_1", "punggol-settlement_2"],
        openTime: "11:00",
        closeTime: "23:00",
        district: punggol,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.35, pace: 0.40, mobility: 0.85, transport: 0.65, walkability: 0.80
        )
    )

    static let poi_loris_buangkok_124 = POI(
        name: "Loris Buangkok",
        desc: "Singapore's last remaining kampong (traditional village) offering a glimpse of the past.",
        address: "Lor Buangkok",
        photoUrls: ["loris-buangkok_1", "loris-buangkok_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: punggol,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.45, pace: 0.30, mobility: 0.60, transport: 0.60, walkability: 0.70
        )
    )

    static let poi_waterway_point_125 = POI(
        name: "Waterway Point",
        desc: "A major suburban shopping mall integrated with the Punggol Waterway.",
        address: "83 Punggol Central",
        photoUrls: ["waterway-point_1", "waterway-point_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: punggol,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.40, pace: 0.50, mobility: 0.95, transport: 0.95, walkability: 1.00
        )
    )

    static let poi_punggol_container_park_126 = POI(
        name: "Punggol Container Park",
        desc: "A trendy lifestyle hub made of shipping containers featuring unique eateries.",
        address: "50 Punggol E",
        photoUrls: ["punggol-container-park_1", "punggol-container-park_2"],
        openTime: "12:00",
        closeTime: "00:00",
        district: punggol,
        categories: [culinary, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.78, proximity: 0.35, pace: 0.50, mobility: 0.80, transport: 0.65, walkability: 0.75
        )
    )

    static let poi_sunrise_bridge_127 = POI(
        name: "Sunrise Bridge",
        desc: "An iconic bridge on the Punggol Waterway, perfect for watching the early morning sun.",
        address: "Punggol Waterway Park",
        photoUrls: ["sunrise-bridge_1", "sunrise-bridge_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: punggol,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.70, proximity: 0.38, pace: 0.60, mobility: 0.80, transport: 0.70, walkability: 0.85
        )
    )

    static let poi_gelam_gallery_128 = POI(
        name: "Gelam Gallery",
        desc: "Singapore’s first outdoor art gallery featuring murals and framed art in back lanes.",
        address: "Muscat St",
        photoUrls: ["gelam-gallery_1", "gelam-gallery_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: kampong_glam,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.72, proximity: 0.85, pace: 0.40, mobility: 0.80, transport: 0.90, walkability: 0.95
        )
    )

    static let poi_vintage_camera_museum_129 = POI(
        name: "Vintage Camera Museum",
        desc: "A unique museum shaped like a camera, housing over 1,000 vintage photography pieces.",
        address: "815 North Bridge Rd",
        photoUrls: ["vintage-camera-museum_1", "vintage-camera-museum_2"],
        openTime: "10:30",
        closeTime: "19:30",
        district: kampong_glam,
        categories: [entertainment, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.68, proximity: 0.85, pace: 0.35, mobility: 0.85, transport: 0.90, walkability: 0.90
        )
    )

    static let poi_bussorah_street_130 = POI(
        name: "Bussorah Street",
        desc: "A pedestrianized palm-lined street leading to Sultan Mosque, filled with shops and cafes.",
        address: "Bussorah St",
        photoUrls: ["bussorah-street_1", "bussorah-street_2"],
        openTime: "10:00",
        closeTime: "22:00",
        district: kampong_glam,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.88, pace: 0.45, mobility: 0.90, transport: 0.95, walkability: 1.00
        )
    )

    static let poi_bugis_street_market_131 = POI(
        name: "Bugis Street Market",
        desc: "The largest and oldest Anglican cathedral in Singapore, featuring stunning neo-Gothic architecture and a brilliant white facade.",
        address: "3 New Bugis Street, S188867",
        photoUrls: ["bugis-street-market_1", "bugis-street-market_2"],
        openTime: "11:00",
        closeTime: "22:00",
        district: bugis,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.90, pace: 0.40, mobility: 0.70, transport: 0.50, walkability: 0.90
        )
    )

    static let poi_indian_heritage_centre_132 = POI(
        name: "Indian Heritage Centre",
        desc: "A sustainable heritage institution showcasing the history and culture of the Indian diaspora.",
        address: "5 Campbell Lane",
        photoUrls: ["indian-heritage-centre_1", "indian-heritage-centre_2"],
        openTime: "10:00",
        closeTime: "18:00",
        district: little_india,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.82, proximity: 0.85, pace: 0.40, mobility: 0.90, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_tan_teng_niah_house_133 = POI(
        name: "Tan Teng Niah House",
        desc: "The last surviving Chinese villa in Little India, famous for its extremely colorful facade.",
        address: "37 Kerbau Rd",
        photoUrls: ["tan-teng-niah-house_1", "tan-teng-niah-house_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: little_india,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.85, proximity: 0.85, pace: 0.30, mobility: 0.80, transport: 0.95, walkability: 1.00
        )
    )

    static let poi_little_india_arcade_134 = POI(
        name: "Little India Arcade",
        desc: "A cluster of conserved shophouses offering traditional snacks, henna art, and textiles.",
        address: "48 Serangoon Rd",
        photoUrls: ["little-india-arcade_1", "little-india-arcade_2"],
        openTime: "09:00",
        closeTime: "22:00",
        district: little_india,
        categories: [shopping, nature, culture],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.85, pace: 0.50, mobility: 0.85, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_st__andrew_s_cathedral_135 = POI(
        name: "St. Andrew’s Cathedral",
        desc: "It offers a high-energy shopping experience that blends traditional bazaar vibes with modern youth culture.",
        address: "11 St Andrew's Rd",
        photoUrls: ["st-andrew-s-cathedral_1", "st-andrew-s-cathedral_2"],
        openTime: "09:00",
        closeTime: "16:00",
        district: civic_district,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.75, proximity: 0.90, pace: 0.60, mobility: 0.90, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_peranakan_museum_136 = POI(
        name: "Peranakan Museum",
        desc: "Explores the culture and heritage of Peranakan communities in Southeast Asia.",
        address: "39 Armenian St, S179941",
        photoUrls: ["peranakan-museum_1", "peranakan-museum_2"],
        openTime: "10:00",
        closeTime: "19:00",
        district: civic_district,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.80, proximity: 0.85, pace: 0.35, mobility: 0.85, transport: 0.90, walkability: 0.95
        )
    )

    static let poi_fort_canning_park_137 = POI(
        name: "Fort Canning Park",
        desc: "An iconic hilltop landmark filled with WWII history and lush recreational space.",
        address: "River Valley Rd, S179037",
        photoUrls: ["fort-canning-park_1", "fort-canning-park_2"],
        openTime: "00:00",
        closeTime: "23:59",
        district: river_valley,
        categories: [nature, culture, metro],
        priorities: createDistrictPriorities(
            popularity: 0.88, proximity: 0.85, pace: 0.70, mobility: 0.60, transport: 0.90, walkability: 0.80
        )
    )

    static let poi_the_arts_house_138 = POI(
        name: "The Arts House",
        desc: "A multidisciplinary arts centre occupying the building of Singapore's first Parliament.",
        address: "1 Old Parliament Ln",
        photoUrls: ["the-arts-house_1", "the-arts-house_2"],
        openTime: "10:00",
        closeTime: "21:00",
        district: civic_district,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.72, proximity: 0.88, pace: 0.30, mobility: 0.85, transport: 0.95, walkability: 1.00
        )
    )

    static let poi_civil_defence_museum_139 = POI(
        name: "Civil Defence Museum",
        desc: "Housed in the oldest fire station, showcasing the history of firefighting in Singapore.",
        address: "62 Hill St, S179367",
        photoUrls: ["civil-defence-museum_1", "civil-defence-museum_2"],
        openTime: "10:00",
        closeTime: "17:00",
        district: civic_district,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.65, proximity: 0.85, pace: 0.40, mobility: 0.85, transport: 0.95, walkability: 0.95
        )
    )

    static let poi_national_archives_140 = POI(
        name: "National Archives",
        desc: "A heritage building housing the collective memory and historical records of the nation.",
        address: "1 Canning Rise, S179868",
        photoUrls: ["national-archives_1", "national-archives_2"],
        openTime: "10:00",
        closeTime: "21:00",
        district: civic_district,
        categories: [culture, nature, metro],
        priorities: createDistrictPriorities(
            popularity: 0.60, proximity: 0.85, pace: 0.30, mobility: 0.85, transport: 0.90, walkability: 0.90
        )
    )

    static var poiData: [POI] {
        return [poi_national_orchird_garden_2, poi_macritchie_reservoir_3, poi_henderson_waves_4, poi_sands_skypark_observation_deck_5, poi_art_science_museum_6, poi_joo_chiat_7, poi_sungei_buloh_wetland_reserve_8, poi_east_coast_park_9, poi_ion_orchard_10, poi_mustafa_centre_11, poi_bugis_junction_12, poi_wings_of_time_13, poi_duck_tours_14, poi_the_hive_15, poi_marina_barrage_16, poi_science_centre_17, poi_bukit_timah_nature_reserve_18, poi_punggol_waterway_park_19, poi_victoria_theatre_20, poi_spectra_light___water_show_21, poi_the_intan_22, poi_snow_city_23, poi_chinese_garden_24, poi_gardens_by_the_bay_25, poi_buddha_tooth_relic_26, poi_marina_bay_sands_27, poi_merlion_park_28, poi_universal_studios_29, poi_jewel_changi_airport_30, poi_clarke_quay_31, poi_botanic_gardens_32, poi_chinatown_market_33, poi_little_india_34, poi_artscience_museum_35, poi_national_gallery_36, poi_night_safari_37, poi_haji_lane_38, poi_singapore_flyer_39, poi_sentosa_luge_40, poi_lau_pa_sat_41, poi_henderson_waves_42, poi_s_e_a__aquarium_43, poi_orchard_road_44, poi_fort_canning_park_45, poi_asian_civ_museum_46, poi_esplanade_47, poi_mount_faber_park_48, poi_national_museum_49, poi_river_wonders_50, poi_tiong_bahru_51, poi_suntec_fountain_52, poi_palawan_beach_53, poi_bird_paradise_54, poi_singapore_zoo_55, poi_macritchie_56, poi_helix_bridge_57, poi_peranakan_museum_58, poi_sri_mariamman_59, poi_sultan_mosque_60, poi_adventure_cove_61, poi_emerald_hill_62, poi_library_orchard_63, poi_old_hill_police_stn_64, poi_siloso_beach_65, poi_madame_tussauds_66, poi_vivocity_sky_park_67, poi_jurong_lake_garden_68, poi_maxwell_food_ctr_69, poi_skyhelix_sentosa_70, poi_plaza_singapura_71, poi_pulau_ubin_72, poi_arab_street_73, poi_tekka_centre_74, poi_rail_corridor_75, poi_singapore_cable_car_76, poi_tanjong_beach_77, poi_mint_museum_of_toys_78, poi_fort_siloso_79, poi_chomp_chomp_food_centre_80, poi_changi_chapel___museum_81, poi_coney_island_82, poi_malay_heritage_centre_83, poi_trick_eye_museum_84, poi_east_coast_lagoon_food_village_85, poi_dempsey_hill_86, poi_funan_mall_87, poi_battlebox_88, poi_national_design_centre_89, poi_istana_heritage_gallery_90, poi_armenian_church_91, poi_hortpark_92, poi_woodlands_waterfront_jetty_93, poi_lower_peirce_reservoir_94, poi_upper_seletar_reservoir_95, poi_chesnut_nature_park_96, poi_labrador_nature_reserve_97, poi_pasir_ris_park_98, poi_hydrodash_99, poi_jewel_canopy_park_100, poi_changi_experience_studio_101, poi_air_force_museum_102, poi_science_centre_singapore_103, poi_keppel_bay_104, poi_design_orchard_105, poi_city_square_mall_106, poi_millenia_walk_107, poi_one_raffles_place_108, poi_zion_riverside_food_centre_109, poi_old_airport_road_food_centre_110, poi_satay_by_the_bay_111, poi_amoy_street_food_centre_112, poi_ghim_moh_market_113, poi_bright_hill_temple_114, poi_kwan_im_thong_hood_cho_115, poi_sri_krishnan_temple_116, poi_maghain_aboth_synagogue_117, poi_clarke_quay_118, poi_asian_civilisations_museum_119, poi_bollywood_farms_120, poi_jurong_frog_farm_121, poi_kranji_war_memorial_122, poi_punggol_settlement_123, poi_loris_buangkok_124, poi_waterway_point_125, poi_punggol_container_park_126, poi_sunrise_bridge_127, poi_gelam_gallery_128, poi_vintage_camera_museum_129, poi_bussorah_street_130, poi_bugis_street_market_131, poi_indian_heritage_centre_132, poi_tan_teng_niah_house_133, poi_little_india_arcade_134, poi_st__andrew_s_cathedral_135, poi_peranakan_museum_136, poi_fort_canning_park_137, poi_the_arts_house_138, poi_civil_defence_museum_139, poi_national_archives_140]
    }
}
