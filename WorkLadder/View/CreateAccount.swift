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
            // .position(CGPoint(x: 20.0, y: 90.0))
                .padding(.leading , -150)
            TextField("Username", text: $username)
                .padding()
                .frame(width: 320, height: 50)
                .background(Color.black.opacity(0.03))
                .shadow(radius: 10)
                .cornerRadius(10.0)
            //  .position(CGPoint(x: 167.0, y: 14.0))
                .padding(.horizontal , 90)
            
            TextField("Email", text: $email)
                .padding()
                .frame(width: 320, height: 50)
                .background(Color.black.opacity(0.03))
                .shadow(radius: 10)
                .cornerRadius(10.0)
            // .position(CGPoint(x: 167.0, y: -35.0))
                .padding(.horizontal , 90)
            
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 320, height: 50)
                .background(Color.black.opacity(0.03))
                .shadow(radius: 10)
                .cornerRadius(10.0)
            //  .position(CGPoint(x: 167.0, y: -84.0))
                .padding(.horizontal , 90)
            
            
            SecureField("Confirm your Password", text: $password)
                .padding()
                .frame(width: 320, height: 50)
                .background(Color.black.opacity(0.03))
                .shadow(radius: 10)
                .cornerRadius(10.0)
            // .position(CGPoint(x: 167.0, y: -133.0))
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
                // .position(CGPoint(x: 184.0, y: -90.0))
                .padding()
                
                }
        }.navigationTitle("Create Account")
        }
    }
}
    
    #Preview {
        CreateAccount()
    }

