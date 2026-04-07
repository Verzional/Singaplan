//
//  ExperienceModel.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 07/04/26.
//

import Foundation
import SwiftData

@Model
final class ExperienceModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var desc: String
    var segments: [ExperienceSegment]
    var selectedWeight: Double = 0.5
    
    init(id: UUID = UUID(), title: String, desc: String, segments: [ExperienceSegment]) {
        self.id = id
        self.title = title
        self.desc = desc
        self.segments = segments
    }
}

struct ExperienceSegment: Codable, Hashable {
    let label: String
    let weight: Double
}
