//
//  RewardPage.swift
//  WorkLadder
//
//  Created by Razan Bin Khudhair on 25/01/2024.
//

import SwiftUI

struct RewardPage: View {
    var body: some View {
        NavigationView {
            Text("Content")
                .navigationTitle("Rewards")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Add your action here
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
        }

    }
}

#Preview {
    RewardPage()
}
