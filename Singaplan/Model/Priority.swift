//
//  ExperienceModel.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 07/04/26.
//

import Foundation
import SwiftData

@Model
final class Priority {
    @Attribute(.unique) var id: UUID
    var title: String
    var desc: String
    var segments: [PrioritySegment]
    var selectedWeight: Double = 0.5
    
    init(id: UUID = UUID(), title: String, desc: String, segments: [PrioritySegment]) {
        self.id = id
        self.title = title
        self.desc = desc
        self.segments = segments
    }
}

struct PrioritySegment: Codable, Hashable {
    let label: String
    let weight: Double
}
