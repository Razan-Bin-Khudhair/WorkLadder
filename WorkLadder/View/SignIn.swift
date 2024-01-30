//
//  SignIn.swift
//  WorkLadder
//
//  Created by Shahad Nasser AL Salem on 17/07/1445 AH.
//

import SwiftUI

struct SignIn: View {
    @State private var username = ""
    @State  private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var showCreatAccount = false

    
    var body: some View {
        NavigationView{
            

            VStack(alignment: .center) {
                Spacer()
                Text("Sign in to get started")
                
                    .font(Font.custom("SF Pro", size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.17))
                    .frame(width: 280, alignment: .center)
                    .padding()
                
                
                ZStack{
                    
                    TextField("Enter your Email", text: $username)
                        .font(Font.custom("SF Pro", size: 18))
                        .padding()
                        .frame(width: 320, height: 60)
                        .background(Color.black.opacity(0.03))
                        .shadow(radius: 10)
                        .cornerRadius(10.0)
                        .border(.red, width: CGFloat(wrongUsername))
                        .keyboardType(.emailAddress)
                    
                }
                
                
                ZStack{
                    
                
                    SecureField("Enter your Password", text: $password)
                        .font(Font.custom("SF Pro", size: 18))
                        .padding()
                        .frame(width: 320, height: 60)
                        .background(Color.black.opacity(0.03))
                        .shadow(radius: 10)
                        .cornerRadius(10.0)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                }
                
                Button("Forgot Password?") {
                    
                }
                
                .padding(.leading , 140)
                .bold()
                .foregroundColor(.blue)
                
                Spacer()
                
                
                
                Button {
                    // showCreatAccount.toggle()
                } label: {
                Text("Login")
                .font(Font.custom("SF Pro", size: 18))
                .foregroundColor(.white)
                .bold()
                .frame(width: 320, height: 60)
                .background(Color.blue)
                .cornerRadius(10)
            }
                
                
                Button  {
                
                } label: {
                    HStack(spacing: 8){
                        Image(systemName: ("apple.logo"))
                            .foregroundColor(.white)
                            .font(Font.custom("SF Pro", size: 20))
                         
                        
                        Text("Sign up with Apple")
                            .font(Font.custom("SF Pro", size: 18))
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                    
                    .frame(width: 320, height: 60)
                    .background(Color.black)
                    .cornerRadius(10)
                }

                HStack (spacing: 5) {
                    
                    Text("Don't have an account?")
                        .foregroundColor(Color.black.opacity(0.8))
                        .font(Font.custom("SF Pro", size: 15))
                    
                    Button {
                        showCreatAccount.toggle()
                    } label: {
                        
                        
                        Text ("Register Now")
                            .bold()
                            .foregroundColor(.blue)
                            .font(Font.custom("SF Pro", size: 15))
                        
                    }.sheet(isPresented: $showCreatAccount, content: {
                        CreateAccount()
                    })
                }
                Spacer()
                Spacer()
                Spacer()
                
                
                
                
            }
            
            .navigationTitle("Sign In")
            
        }
        
        
        
    }
        
        
    }


    
    #Preview{
        SignIn()
            }
