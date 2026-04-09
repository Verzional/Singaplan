//
//  ItineraryFolderList.swift
//  Singaplan
//
//  Created by Michelle on 07/04/26.
//

import SwiftUI

struct ItineraryFolderList: View {
    var folderName: String
    var days: String
    var onBack: () -> Void
    
    var body: some View {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(folderName)
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("\(days) Days")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                Spacer()
                
                Image(systemName: "greaterthan")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
            }
            .frame(width: 334, height: 85)
            .padding()
            .background(Color.black)
            .cornerRadius(16)
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
    }
#Preview {
    ItineraryFolderList(
        folderName: "Girls Trip",
        days: "4",
        onBack: { print("Back") }
    )
}
