//
//  CreateAccount.swift
//  WorkLadder
//
//  Created by Shahad Nasser AL Salem on 17/07/1445 AH.
//

import SwiftUI


import SwiftUI

struct CreateAccount: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var Cpassword: String = ""
    
    var body: some View {
        NavigationView {
        VStack(alignment: .center) {
            
            Text("Sign up to get started!")
                .font(Font.custom("SF Pro", size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                .frame(width: 280, alignment: .center)
                .padding()
            
            TextField("Username", text: $username)
                .padding()
                .frame(width: 320, height: 60)
                .background(Color.black.opacity(0.03))
                .shadow(radius: 10)
                .cornerRadius(10.0)
                .padding(.horizontal , 90)
            
            TextField("Email", text: $email)
                .padding()
                .frame(width: 320, height: 60)
                .background(Color.black.opacity(0.03))
                .shadow(radius: 10)
                .cornerRadius(10.0)
                .padding(.horizontal , 90)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 320, height: 60)
                .background(Color.black.opacity(0.03))
                .shadow(radius: 10)
                .cornerRadius(10.0)
                .padding(.horizontal , 90)
            
            
            SecureField("Confirm your Password", text: $password)
                .padding()
                .frame(width: 320, height: 60)
                .background(Color.black.opacity(0.03))
                .shadow(radius: 10)
                .cornerRadius(10.0)
                .padding(.horizontal , 90)
            
            Button(action: {
                
                print("Username: \(username)")
                print("Email: \(email)")
                print("Password: \(password)")
            }) {
                Button("Create Account") {
                }
                .foregroundColor(.white)
                .bold()
                .frame(width: 320, height: 60)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
                
                }
            
        }.navigationTitle("Create Account")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Add your "Cancel" action here
                        }) {
                            Text("Cancel")
                        }
                    }

                }


        }
    }
}
    
    #Preview {
        CreateAccount()
    }

