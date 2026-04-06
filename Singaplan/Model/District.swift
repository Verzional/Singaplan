//
//  District.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 06/04/26.
//

import Foundation

struct District: Identifiable {
    let id: String
    var name: String
    var address: String
    var description: String
    var photoUrl: String
    var photos: [Photo]
}
