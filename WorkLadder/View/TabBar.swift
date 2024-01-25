//
//  TabBar.swift
//  WorkLadder
//
//  Created by Razan Bin Khudhair on 25/01/2024.
//

import SwiftUI

struct TabBar: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
          
            TasksPage()
            
                .tag(0)
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tasks")
                }
            
            LeaderboardPage_()
                .tag(1)
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("Leaderboard")
                }
            
            
            RewardPage()
                .tag(2)
                .tabItem {
                    Image(systemName: "gift.fill")
                    Text("Rewards")
                }
            
            
        }
        //.accentColor(Color(red: 0.67, green: 0.75, blue: 0.64))
    }
}

#Preview {
    TabBar()
}
