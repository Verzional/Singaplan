//
//  Priority.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class PriorityModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var weight: Int
    
    init(id: UUID = UUID(), title: String, weight: Int) {
        self.id = id
        self.title = title
        self.weight = weight
    }
}
