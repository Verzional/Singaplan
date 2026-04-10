//
//  Photo.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation
import SwiftData

@Model
final class Photo {
    var id: String
    var url: String
    init(id: String, url: String) {
        self.id = id
        self.url = url
    }
}
