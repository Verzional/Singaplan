//
//  RecommendationFlowManager.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 13/04/26.
//


import Foundation
import SwiftData
import Observation

@Observable
class FlowManager {
    var selectedCategoryPreset: CategoryPreset?
    var selectedPriorityPreset: PriorityPreset?
    var targetDay: ItineraryDay?
    
    func reset() {
        selectedCategoryPreset = nil
        selectedPriorityPreset = nil
        targetDay = nil
    }
}
