import Foundation
import SwiftData

@Model
final class District {
    @Attribute(.unique) var id: UUID
    var name: String
    var address: String
    var desc: String
    var photoUrls: [String]
    
    @Relationship(deleteRule: .nullify)
    var priorities: [Priority]? = []
        
    @Relationship(deleteRule: .nullify)
    var categories: [Category]? = []
    
    @Relationship(deleteRule: .nullify, inverse: \POI.district)
    var pois: [POI] = []
    
    init(
        id: UUID = UUID(),
        name: String,
        address: String,
        desc: String,
        photoUrls: [String],
        priorities: [Priority]? = nil,
        categories: [Category]? = nil
    ) {
        self.id = id
        self.name = name
        self.address = address
        self.desc = desc
        self.photoUrls = photoUrls
        self.priorities = priorities
        self.categories = categories
    }
}
