//
//  RecommendationFlowManager.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 13/04/26.
//


import Foundation
import SwiftData
import Observation
import SwiftUI

enum DiscoverRoute: Hashable {
    case categoryPreset
    case priorityPreset
    case recommendedDistricts
    case recommendedPOIs
}

@Observable
class FlowManager {
    var selectedCategoryPreset: CategoryPreset?
    var selectedPriorityPreset: PriorityPreset?
    var targetDay: ItineraryDay?
    var selectedDistrict: District?
    var navigationPath = NavigationPath()
    
    func reset() {
        selectedCategoryPreset = nil
        selectedPriorityPreset = nil
        targetDay = nil
        selectedDistrict = nil
    }
    
    func popToItineraryDetail() {
        if navigationPath.count > 1 {
            navigationPath.removeLast(navigationPath.count - 1)
        }
        reset()
    }
}
