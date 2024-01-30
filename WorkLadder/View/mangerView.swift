//
//  mangerView.swift
//  WorkLadder
//
//  Created by sarah alothman on 18/07/1445 AH.
//

import SwiftUI

struct mangerView: View {
    @State private var showAlert = false
    @State private var userScore = 100 // Set the user's score here
    @State private var isAddRewardSheetPresented = false
    @State private var newScore = ""
    @State private var newReward = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false

    var rewards: [Reward] = [
        Reward(id: 1, name: "Reward 1", imageName: "Apple", pointsRequired: 100),
        Reward(id: 2, name: "Reward 2", imageName: "Apple", pointsRequired: 90),
        Reward(id: 3, name: "Reward 3", imageName: "Apple", pointsRequired: 200),
        Reward(id: 4, name: "Reward 4", imageName: "Lock", pointsRequired: 250),
        Reward(id: 5, name: "Reward 5", imageName: "Apple", pointsRequired: 300),
        Reward(id: 6, name: "Reward 6", imageName: "Lock", pointsRequired: 310),
        // Add more rewards with their respective pointsRequired
    ]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text("Rewards Management")
                        .font(.system(size: 30))
                        .font(.title)
                        .bold()
                        .offset(x: -10, y: -35)

                    // Display all rewards
                    ForEach(rewards) { reward in
                        if userScore >= reward.pointsRequired {
                            RectangleRow()
                                .padding(.bottom, -40)
                        } else {
                            LockedRectangleRow()
                                .padding(.bottom, -40)
                        }
                    }
                }
            }
            .navigationBarItems(trailing:
                Button(action: {
                    isAddRewardSheetPresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                }
            )
            .navigationBarTitle("", displayMode: .inline)
            .sheet(isPresented: $isAddRewardSheetPresented) {
                NavigationView {
                    VStack {
                        Form {
                            Section(header:
                                HStack {
                                    Spacer()
                                    Button("Cancel") {
                                        isAddRewardSheetPresented.toggle()
                                    }
                                    .font(.system(size: 15))
                                    .offset(x:-240,y: -50)
                                    .foregroundColor(.blue)
                                
                                
                                Button("Add") {
                                    isAddRewardSheetPresented.toggle()
                                }
                                .font(.system(size: 15))
                                .offset(x:20,y: -50)
                                .foregroundColor(.blue)
                                }
                            ) {
                                TextField("Score", text: $newScore)
                                    .keyboardType(.numberPad)
                                TextField("Reward", text: $newReward)
                                Button(action: {
                                    isImagePickerPresented.toggle()
                                }) {
                                    HStack {
                                        Text("Upload Photo")
                                        Spacer()
                                        Image(systemName: "photo")
                                    }
                                }
                            }
                        }
                        .imagePicker(isPresented: $isImagePickerPresented, selectedImage: $selectedImage)
                        .navigationBarTitle("New Reward", displayMode: .inline)
                    }
                }
            }
        }
    }
}

struct RectangleRow: View {
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

struct LockedRectangleRow: View {
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

struct Reward: Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let pointsRequired: Int
}

struct mangerView_Previews: PreviewProvider {
    static var previews: some View {
        mangerView()
    }
}

extension Form {
    func imagePicker(isPresented: Binding<Bool>, selectedImage: Binding<UIImage?>) -> some View {
        modifier(ImagePicker(isPresented: isPresented, selectedImage: selectedImage))
    }
}

struct ImagePicker: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage?

    func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresented) {
            ImagePickerView(selectedImage: $selectedImage)
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: UIImage?

        init(selectedImage: Binding<UIImage?>) {
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedImage = uiImage
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
