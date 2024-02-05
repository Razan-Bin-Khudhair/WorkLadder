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
    let DueDate: Date
    var priority: String
    let name: String
}

struct TasksPageAdmin: View {
    
    @State private var tasks: [Task] = []
    @State private var isPresentingAddTaskSheet = false
    @State private var newTaskTitle = ""
    @State private var newTaskDescription = ""
    @State private var newTaskStatus = 0

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Picker(selection: $newTaskStatus, label: Text("Select Status")) {
                        Text("To do").tag(0)
                        Text("In progress").tag(1)
                        Text("Done").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    ScrollView {
                        Spacer()
                        ForEach(tasks.indices, id: \.self) { index in
                            if tasks[index].status == getStatusTitle(newTaskStatus) {
                                RectangleView(task: tasks[index], status: $tasks[index].status)
                                    .padding(10)
                                    .contextMenu {
                                        Button(action: {
                                            deleteTask(at: IndexSet([index]))
                                        }) {
                                            Text("Delete")
                                            Image(systemName: "trash")
                                        }
                                    }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Tasks Management")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingAddTaskSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isPresentingAddTaskSheet) {
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

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

struct RectangleView: View {
    var task: Task
    @Binding var status: String
    @State private var isShowingDatePicker = false
    @State private var selectedDueDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(task.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading)

                Text(task.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .lineLimit(nil)

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
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: getStatusImageName(for: status))
                                .foregroundColor(getStatusColor(for: status))
                                .font(.title3)
                            Text(status)
                                .font(.system(size: 12))
                        }.frame(height: 24)
                            .padding(.horizontal, 8)
                            .font(.system(size: 12))
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.9), lineWidth: 0.8)
                                    .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: 2)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }//.buttonStyle(RectangleButtonStyle())

                    CircleWithRectangle(color: getPriorityColor(), text: task.priority)
                        .buttonStyle(RectangleButtonStyle())

                   
                
                }
                
                Spacer(minLength: -30)
                
                HStack {
                    
                    ImageWithRectangle(image: Image(systemName: "person.fill"), text: task.name)
                        .buttonStyle(RectangleButtonStyle())
                    
                    Spacer()
                }
                
            //
                
            }.padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: 350,height: 180)
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
            .frame(height: 24)
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
                .frame(width: 19, height: 19)
                .overlay(
                    Circle()
                        .stroke(Color.gray, lineWidth: 0.1)
                )
            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 12))
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
                .frame(height: 24)
        )
    }
}

struct ImageWithRectangle: View {
    let image: Image
    let text: String

    var body: some View {
        HStack(spacing: 4) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
                .clipShape(Circle())

            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 12))
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.8), lineWidth: 0.5)
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
    @State private var selectedName = "None"
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
                    DatePicker("Due Date", selection: $DueDate, displayedComponents: .date)
                }

                Section(header: Text("Employee")) {
                    Picker(selection: $selectedName, label: Text("Name")) {
                        Text("Razan").tag("Razan")
                        Text("Rima").tag("Rima")
                        Text("Shahad").tag("Shahad")
                        Text("Mariyyah").tag("Mariyyah")
                        Text("Sarah").tag("Sarah")
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
                trailing: Button(action: {
                    let task = Task(title: newTaskTitle, description: newTaskDescription, status: getStatusTitle(newTaskStatus), DueDate: DueDate, priority: selectedPriority, name: selectedName)
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


