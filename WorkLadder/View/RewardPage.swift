//
//  RewardPage.swift
//  WorkLadder
//
//  Created by Razan Bin Khudhair on 25/01/2024.
//

import SwiftUI

struct RewardPage: View {
    @State private var showAlert = false
    @State private var userScore = 100 // Set the user's score here
    var rewards: [UserReward] = [
        UserReward(id: 1, name: "Reward 1", imageName: "Apple", pointsRequired: 100 ),
        UserReward(id: 2, name: "Reward 2", imageName: "Apple", pointsRequired: 90),
        UserReward(id: 3, name: "Reward 3", imageName: "Apple", pointsRequired: 200),
        UserReward(id: 4, name: "Reward 4", imageName: "Lock", pointsRequired: 250),
        UserReward(id: 5, name: "Reward 5", imageName: "Apple", pointsRequired: 300),
        UserReward(id: 6, name: "Reward 6", imageName: "Lock", pointsRequired: 310),
        // Add more rewards with their respective pointsRequired
    ]

    var body: some View {
        VStack {
            ScrollView {
                Text("Profile")
                    .font(.system(size: 34))
                    .font(.title)
                    .bold()
                    .offset(x: -110, y: -10)
                
                Button(action: {}, label: {
                    Image("AV2")
                        .resizable()
                        .frame(width: 75, height: 77)
                        .offset(y: -10)
                })

                Text("Sarah Alothman")
                    .bold()
                    .offset(y: -10)
                    .font(.system(size: 24))

                Text("My Rewards")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 25))
                    .bold()
                    .offset(x: -90, y: 13)

                // Display all rewards
                ForEach(rewards) { reward in
                    if userScore >= reward.pointsRequired {
                        UserRectangleRow()
                            .padding(.bottom, -35)
                    } else {
                        UserLockedRectangleRow()
                            .padding(.bottom, -35)
                    }
                }
            }
        }
    }
}

struct UserRectangleRow: View {
   

    var body: some View {
        Button(action: {
            // Handle the action for unlocked reward
        }, label: {
            ZStack {
                Image("Apple")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                   
            }
        })
    }
}

struct UserLockedRectangleRow: View {
    @State private var showAlert = false

    var body: some View {
        Button(action: {
            showAlert.toggle()
        }, label: {
            ZStack {
                Image("Lock")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                   
            }
           
        })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Insufficient Points"),
                message: Text("Your points are not enough."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct UserReward: Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let pointsRequired: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RewardPage()
    }
}
