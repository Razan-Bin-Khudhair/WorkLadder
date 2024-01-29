//
//  LeaderboardPage .swift
//  WorkLadder
//
//  Created by Razan Bin Khudhair on 25/01/2024.
//

import SwiftUI

struct LeaderboardPage_: View {
    @State private var isSheetPresented = false
    @State private var email = "marya.as1@gmail.com"
    @State private var employeeName = ""
    @State private var employeeEmail = ""
    @State private var selectedGender = "M"
    
    
    @State private var progressBoxes: [ProgressBox] = [
        ProgressBox(gender: "F", name: "Alice", points: 30),
        ProgressBox(gender: "M", name: "Bob", points: 40),
        ProgressBox(gender: "F", name: "Eve", points: 50),
        ProgressBox(gender: "M", name: "Charlie", points: 10)
    ]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Leaderboard")
                        .font(.title)
                        .bold()
                        .padding(.top, 10)
                        .padding(.leading, 20)
                    
                    if email == "marya.as1@gmail.com" {
                        Image(systemName: "plus")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 25))
                            .padding(.leading, 130)
                            .padding(.top, 10)
                            .onTapGesture {
                                isSheetPresented.toggle()
                            }
                            .sheet(isPresented: $isSheetPresented) {
                                // Content of the sheet goes here
                                VStack {
                                    HStack {
                                        Text("Cancel")
                                            .foregroundColor(Color.blue)
                                            .padding()
                                            .onTapGesture {
                                                isSheetPresented.toggle()
                                            }
                                            .padding(.leading, -10)
                                        
                                        Spacer()
                                        
                                        Text("New Employee")
                                            .font(.system(size: 19)).offset(x:-20)
                                        
                                        Spacer()
                                        
                                        Text("Add")
                                            .foregroundColor(Color.blue)
                                           // .padding()
                                            .onTapGesture {
                                                // Add employee to progressBoxes
                                                progressBoxes.append(ProgressBox(gender: selectedGender, name: employeeName, points: 0))
                                                isSheetPresented.toggle()
                                            }.padding(.leading, -20)
                                            .padding(.trailing, 20)
                                    }.padding(.top,-360)
                                    
                                    TextField("Name", text: $employeeName)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                        .padding(.top, -260)
                                    
                                    TextField("Email", text: $employeeEmail)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                        .padding(.top, -200)
                                    
                                    Picker("Gender", selection: $selectedGender) {
                                        Text("Female").tag("F")
                                        Text("Male").tag("M")
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .padding(.top, -140)
                                }
                                .padding()
                            }
                    }
                }
                
                VStack {
                    Spacer().frame(height: 40)
                    
                    ForEach(progressBoxes.sorted(by: { $0.points > $1.points })) { progressBox in
                        progressBox
                    }
                }
                .padding(.top, 10)
            }
            .padding()
        }



    }
}



struct ProgressBar: View {
    var width: CGFloat
    var points: Int // Add points as a parameter

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule().fill(Color("gray"))
                .frame(width: 230, height: 15)
            
            ZStack {
                Capsule().fill(Color("purple"))
                    .frame(width: width * 0.6, height: 15)
                
             //   HStack {
                    Image(systemName: "gift.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        //.padding(.trailing, CGFloat(points) * 2)
               // }
            }
        }
    }
}



struct ProgressBox: View, Identifiable  {
    var id: String { name }
    
    var gender: String
    var name: String
    var points: Int

    var resultString: String {
        let randomNumber = Int(arc4random_uniform(4)) + 1

        if gender == "F" {
            return "female\(randomNumber)"
        } else if gender == "M" {
            return "male\(randomNumber)"
        } else {
            return ""
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 100)
                .foregroundColor(.white)
                .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
            
            HStack {
                if !resultString.isEmpty{
                    Image(resultString)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .padding(.leading, 25)
                        .padding(.bottom, 20)
                }
                
                VStack(alignment: .leading){
                    ProgressBar(width: CGFloat(points) * 2, points: points) // Pass points to ProgressBar
                        .padding(.trailing, 10)
                        .padding(.bottom, -90)
                    
                    HStack {
                        Text(name).font(.title2).padding(.top, -40)
                        Spacer()
                        Text("\(String(points)) / 100").padding(.top, -23) .offset(x: -7) .font(.system(size: 12, weight: .light)) .foregroundColor(.black)
                        Image(systemName: "dollarsign.circle").padding(.top, -24).offset(x: -10).font(.system(size: 15))
                    }
                }
            }
            .padding(.top, 20)
            .padding(.trailing, 20)
           
           
        }
    }
}







#Preview {
    LeaderboardPage_()
}
