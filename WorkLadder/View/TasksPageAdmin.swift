//
//  TasksPage.swift
//  WorkLadder
//
//  Created by Razan Bin Khudhair on 25/01/2024.
//

import SwiftUI


struct Task: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var status: String
//    let startDate: Date
    let DueDate: Date
    let priority: String // Add priority property
}

struct TasksPageAdmin: View {
    @State private var tasks: [Task] = []
    @State private var isPresentingAddTaskSheet = false
    @State private var newTaskTitle = ""
    @State private var newTaskDescription = ""
    @State private var newTaskStatus = 0
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
     
                    
                    Picker(selection: $newTaskStatus, label: Text("Select Status")) {
                        Text("To do").tag(0)
                        Text("In progress").tag(1)
                        Text("Done").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                   // Spacer()
                    ScrollView {
                        Spacer()
                        ForEach(tasks) { task in
                            if task.status == getStatusTitle(newTaskStatus) {
                                RectangleView(task: task, status: $tasks[getIndex(for: task)].status)
                                    .padding(10)
                            }
                        }
                        Spacer()
                    }
                  //  Spacer()
                }
            }.navigationTitle("Tasks Management")
             .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isPresentingAddTaskSheet = true
                        }) {
                            Image(systemName: "plus")
                        }.sheet(isPresented: $isPresentingAddTaskSheet) {
                            AddTaskView(isPresented: $isPresentingAddTaskSheet, tasks: $tasks)
                        }
                    }
                }
        }
       
    }
    
    func getIndex(for task: Task) -> Int {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return 0
        }
        return index
    }
    
    func getStatusTitle(_ status: Int) -> String {
        switch status {
        case 0:
            return "To Do"
        case 1:
            return "In Progress"
        case 2:
            return "Done"
        default:
            return ""
        }
    }
    
}

struct RectangleView: View {
    let task: Task
    @Binding var status: String
    @State private var isShowingDatePicker = false
    @State private var selectedDueDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .leading, spacing: 15) {
                Text(task.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Text(task.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading)
                
                HStack {
                    Button(action: {
                        isShowingDatePicker = true
                    }) {
                        HStack {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 14))
                            Text(dateFormatter.string(from: selectedDueDate))
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                        }
                    }
                    .buttonStyle(RectangleButtonStyle())
                    .sheet(isPresented: $isShowingDatePicker) {
                        DatePicker(selection: $selectedDueDate, displayedComponents: .date) {
                            Text("Select Due Date")
                        }
                    }
                    
                    Menu {
                        ForEach(["To Do", "In Progress", "Done"], id: \.self) { option in
                            Button(action: {
                                status = option
                            }) {
                                HStack {
                                    Image(systemName: getStatusImageName(for: option))
                                        .foregroundColor(getStatusColor(for: option))
                                        .font(.title3)
                                    Text(option)
                                        .font(.system(size: 12))
                                }
                                .buttonStyle(RectangleButtonStyle())
                                
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: getStatusImageName(for: status))
                                .foregroundColor(getStatusColor(for: status))
                                .font(.title3)
                            Text(status)
                                .font(.system(size: 12))
                        }
                        .buttonStyle(RectangleButtonStyle())
                    }
                    .buttonStyle(RectangleButtonStyle())
                    Spacer()
                    
                    CircleWithRectangle(color: getPriorityColor(), text: task.priority)
                    
                }
               .padding(.horizontal)
            }
        }        .padding()
        
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 137, alignment: .center)
                    .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
                    
                    
            )
    }
    
    func getStatusImageName(for status: String) -> String {
        switch status {
        case "To Do":
            return "pencil.circle.fill"
        case "In Progress":
            return "circle.dashed"
        case "Done":
            return "checkmark.circle.fill"
        default:
            return ""
        }
    }
    
    func getStatusColor(for status: String) -> Color {
        switch status {
        case "To Do":
            return .blue
        case "In Progress":
            return .orange
        case "Done":
            return .green
        default:
            return .black
        }
    }
    
    func getPriorityColor() -> Color {
        switch task.priority {
        case "High":
            return .red
        case "Medium":
            return .orange
        case "Low":
            return .green
        default:
            return .gray
        }
    }
    
}


struct RectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 24) // Set the same height for all rectangles
            .padding(.horizontal, 8)
            .font(.system(size: 12))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.9), lineWidth: 0.8)
                    .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: 2)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct CircleWithRectangle: View {
    let color: Color
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 19, height: 19) // Set the same size for the circle as the one for the status
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 0.1)
                )
            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 12))
        }
        .padding(8) // Adjust padding
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 2)
                .frame(height: 24)
        )
    }
}







struct AddTaskView: View {
    @Binding var isPresented: Bool
    @Binding var tasks: [Task]
    @State private var newTaskTitle = ""
    @State private var newTaskDescription = ""
    @State private var newTaskStatus = 0
    @State private var selectedPriority = "Low"
//    @State private var startDate = Date()
    @State private var DueDate = Date()
    

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $newTaskTitle)
                    TextField("Description", text: $newTaskDescription)

                }
               
                
                Section(header: Text("Priority")) {
                    Picker(selection: $selectedPriority, label: Text("Select Priority")) {
                        Text("Low").tag("Low")
                        Text("Medium").tag("Medium")
                        Text("High").tag("High")
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section(header: Text("Select Dates")) {
//                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("Due Date", selection: $DueDate, displayedComponents: .date)
                }
                
                Section(header: Text("Employee")) {
                    Picker(selection: $selectedPriority, label: Text("Name")) {
                        Text("").tag("")
                        Text("").tag("")
                        Text("").tag("")
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    isPresented = false
                }) {
                    Text("Cancel")
                },
                trailing:Button(action: {
                    let task = Task(title: newTaskTitle, description: newTaskDescription, status: getStatusTitle(newTaskStatus), /*startDate: startDate,*/
                                    DueDate: DueDate, priority: selectedPriority)
                    tasks.append(task)
                    isPresented = false
                }) {
                    Text("Add")
                }
                .disabled(newTaskTitle.isEmpty)
            )
        }
    }
    
    func getStatusTitle(_ status: Int) -> String {
        switch status {
        case 0:
            return "To Do"
        case 1:
            return "In Progress"
        case 2:
            return "Done"
        default:
            return ""
        }
    }
}

#Preview {
    TasksPageAdmin()
}


