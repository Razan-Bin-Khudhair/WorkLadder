//
//  mangerView.swift
//  WorkLadder
//
//  Created by sarah alothman on 18/07/1445 AH.
//

import Photos
import PhotosUI
import SwiftUI
import UIKit

struct Reward: Identifiable {
    let id = UUID()
    let name: String
    let image: UIImage
    let priority: String
}

class RewardManager: ObservableObject {
    @Published var rewards: [Reward] = []
}

struct aa: View {
    @State private var showAddRewardSheet = false
    @State private var newRewardName = ""
    @State private var selectedPriority = "High"
    @State private var selectedImage: UIImage?
 

    @ObservedObject var rewardManager = RewardManager()

    var body: some View {
        NavigationView {
            
            ScrollView {
                Spacer()
                Spacer()
                LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
                    ForEach(rewardManager.rewards) { reward in
                        RewardCell(reward: reward)
                    }
                }//.padding()
               // Spacer()
            }
           

            .navigationBarTitle("Rewards Management")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddRewardSheet.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddRewardSheet) {
                AddRewardView(rewardManager: rewardManager,
                              isPresented: $showAddRewardSheet,
                              selectedPriority: $selectedPriority,
                              selectedImage: $selectedImage)
            }
        }
    }
}

struct AddRewardView: View {
    @ObservedObject var rewardManager: RewardManager
    @Binding var isPresented: Bool
    @State private var showImagePicker = false
    @State private var newRewardName: String = ""
    @Binding var selectedPriority: String
    @Binding var selectedImage: UIImage?

    // Define the priority options
    let priorityOptions = ["High", "Medium", "Low"]

    var body: some View {
        NavigationView {
                  Form {
                      Section(header: Text("Reward Details")) {
                          TextField("Reward Name", text: $newRewardName)
                              
                      }
                    //  .listRowInsets(EdgeInsets(top: -20, leading: -10, bottom: -20, trailing: 10))



                      Section(header: Text("Image")) {
                          Button(action: {
                              self.showImagePicker.toggle()
                          }) {
                              Text("Choose Image")
                                  .frame(maxWidth: .infinity, maxHeight: 40)
                                  .background(Color.white)
                                  .foregroundColor(.blue)
                                  .cornerRadius(8)
                          }
                          .sheet(isPresented: $showImagePicker) {
                              ImagePicker(selectedImage: self.$selectedImage)
                          }
                      }

                    /*  Section(header: Text("Priority")) {
                          Picker("Priority", selection: $selectedPriority) {
                              ForEach(priorityOptions, id: \.self) { option in
                                  Text(option).tag(option)
                              }
                          }
                          .pickerStyle(MenuPickerStyle())
                         // .padding()
                      }*/

                     
                  }
                  .navigationBarTitle("Add Reward")
                  .navigationBarTitleDisplayMode(.inline)
                  .navigationBarItems(
                      leading: Button(action: {
                          isPresented = false
                      }) {
                          Text("Cancel")
                      },
                      trailing: Button(action: {
                          if !newRewardName.isEmpty, let image = selectedImage {
                              rewardManager.rewards.append(Reward(name: newRewardName,
                                                                  image: image,
                                                                  priority: selectedPriority))
                              
                              
                              isPresented = false
                         }
                      }) {
                          Text("Add")
                      }
                      
                  )
        }
    }
}



struct RewardCell: View {
    let reward: Reward

    var body: some View {
        VStack {
            Image(uiImage: reward.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                //.frame(width: UIScreen.main.bounds.width - 10, height: 216)
                .frame(width: 340,height: 200)
                .cornerRadius(8)
                .overlay(
                    Text(reward.name)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8),
                    alignment: .center
                )
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                      //  .foregroundColor(.white)
                        .frame(width: 340,height: 200)
                       // .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                        .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
                )
        }
      //  .frame(maxWidth: .infinity)
        .padding(-5)
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}


struct aa_Previews: PreviewProvider {
    static var previews: some View {
        aa()
    }
}
