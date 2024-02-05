//
//  LeaderboardPage .swift
//  WorkLadder
//
//  Created by Razan Bin Khudhair on 25/01/2024.
//

import SwiftUI

struct LeaderboardPageAdmin: View {
    @State private var isSheetPresented = false
    @State private var email = "marya.as1@gmail.com"
    @State private var employeeName = ""
    @State private var employeeEmail = ""
    @State private var selectedGender = "M"

    @State private var progressBoxes: [ProgressBox] = [
        ProgressBox(gender: "F", name: "Razan", points: 0),
        ProgressBox(gender: "F", name: "Rima", points: 40),
        ProgressBox(gender: "F", name: "Mariyyah", points: 50),
        ProgressBox(gender: "F", name: "Sarah", points: 10),
        ProgressBox(gender: "F", name: "Shahad", points: 10)
    ]

    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack {
                       // Spacer().frame(height: 40)
                        HStack(spacing: 4) {
                            Spacer()
                            
                            Group{
                                Circle()
                                    .fill(.green)
                                    .frame(width: 19, height: 19)
                                Text("10 points")
                            }
                            
                            Spacer()
                            
                            Group{
                                Circle()
                                    .fill(.orange)
                                    .frame(width: 19, height: 19)
                                Text("20 points")
                            }
                            
                            Spacer()
                            
                            Group {
                                Circle()
                                    .fill(.red)
                                    .frame(width: 19, height: 19)
                                Text("30 points")
                            }
                            
                            Spacer()
                        }
                        ForEach(progressBoxes.sorted(by: { $0.points > $1.points })) { progressBox in
                            progressBox
                        }
                    }
                    .padding(.top, 10)
                }
                .padding()
            }

            .navigationTitle("Leaderboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add your action here
                        if email == "marya.as1@gmail.com" {
                            isSheetPresented.toggle()
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                AddEmployeeSheetView(isSheetPresented: $isSheetPresented, progressBoxes: $progressBoxes)
            }
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

                Image(systemName: "gift.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .offset(x: width * 0.3 - 10)
            }
        }
    }
}

struct AddEmployeeSheetView: View {
    @Binding var isSheetPresented: Bool
    @Binding var progressBoxes: [ProgressBox]
    @State private var employeeName = ""
    @State private var employeeEmail = ""
    @State private var selectedGender = "M"

    var isAddButtonDisabled: Bool {
        return employeeName.isEmpty || employeeEmail.isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Employee")) {
                    TextField("Name", text: $employeeName)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)

                    TextField("Email", text: $employeeEmail)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)

                    Picker("Gender", selection: $selectedGender) {
                        Text("Female").tag("F")
                        Text("Male").tag("M")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(5)
            }
            .navigationTitle("Add Employee")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    isSheetPresented.toggle()
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    // Add employee to progressBoxes
                    progressBoxes.append(ProgressBox(gender: selectedGender, name: employeeName, points: 0))
                    isSheetPresented.toggle()
                }) {
                    Text("Add")
                        .foregroundColor(isAddButtonDisabled ? Color.gray : Color.blue)
                        // You can also modify other button properties, e.g., background, font, etc.
                }
                .disabled(isAddButtonDisabled)
            )
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
                    ProgressBar(width: CGFloat(points) * 4, points: points) // Pass points to ProgressBar
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
    LeaderboardPageAdmin()
}
