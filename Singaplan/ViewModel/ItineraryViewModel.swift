//
//  ItineraryViewModel.swift
//  Singaplan
//
//  Created by Valentino Manuel Gunawan on 10/04/26.
//

import Foundation
import Observation
import SwiftData

@Observable
class ItineraryViewModel {
    private var modelContext: ModelContext?
    
    var folderNameInput = ""
    var dayCountInput = ""
    var showModal = false
    
    func prepareNewInput() {
        folderNameInput = ""
        dayCountInput = ""
    }
    
    func saveNewItinerary() {
        guard let modelContext = modelContext,
              !folderNameInput.isEmpty,
              let totalDays = Int(dayCountInput)
        else { return }
        
        let newFolder = Itinerary(folderName: folderNameInput)
        modelContext.insert(newFolder)
        
        for i in 1...totalDays {
            let newDay = ItineraryDay(dayNumber: i)
            newDay.itineraryFolder = newFolder
            modelContext.insert(newDay)
        }
        
        showModal = false
    }
    
    func deleteFolder(_ folder: Itinerary) {
        modelContext?.delete(folder)
    }
}
