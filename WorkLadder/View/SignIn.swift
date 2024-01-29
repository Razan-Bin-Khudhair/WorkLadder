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
                
                //QuickSignInWithApple()
                    //.frame(width: 280, height: 60, alignment: .center)
                  //  .position(CGPoint(x: 190.0, y: 190.0))
                    //.padding()
                
                
                Text("Sign in to get started")
                
                    .padding(.leading , -130)
                
                   // .position(CGPoint(x: 130.0, y: -490.0))
                    .foregroundColor(Color.black.opacity(0.9))
                    .padding( )
                
                
                ZStack{
                   // Image(systemName: ("envelope"))
                    
                    //    .padding(.leading , -140)
                    
                        
                    TextField("Enter your Email", text: $username)
                    
                        .padding()
                        .frame(width: 320, height: 50)
                        .background(Color.black.opacity(0.03))
                        .shadow(radius: 10)
                        .cornerRadius(10.0)

                    // .position(CGPoint(x: 199.0, y: -190.0))
                        .border(.red, width: CGFloat(wrongUsername))
                    
                }
                
                
                ZStack{
                    
                 //   Image(systemName: ("key"))
                   //     .padding(.leading , -140)
                    
                    SecureField("Enter your Password", text: $password)
                        .padding()
                        .frame(width: 320, height: 50)
                        .background(Color.black.opacity(0.03))
                        .shadow(radius: 10)
                        .cornerRadius(10.0)

                    //.position(CGPoint(x: 199.0, y: -179.0))
                        .border(.red, width: CGFloat(wrongUsername))
                        .padding()
                }
                
                Button("Forgot Password?") {
                    
                }
                    .padding(.leading , 140)
                    .bold()
                   // .position(CGPoint(x: 279.0, y: -310.0))
                    .foregroundColor(.blue)
                
                
                
                
                Button("Create Account") {
                    showCreatAccount.toggle()
                }
                .foregroundColor(.white)
                .bold()
                .frame(width: 320, height: 60)
                .background(Color.blue)
                .cornerRadius(10)
              
                
                Button("Sign up with Apple") {
                    showCreatAccount.toggle()
                }
                .foregroundColor(.white)
                .bold()
                .frame(width: 320, height: 60)
                .background(Color.black)
                .cornerRadius(10)
                ZStack {
                    Image(systemName: ("apple.logo"))
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.black)
                        .padding()
                    
            
                }
                
               // QuickSignInWithApple()
                 //   .frame(width: 280, height: 60, alignment: .center)
                 
                   // .padding()
                
                
                Text("Don't have an account?")
                    .foregroundColor(Color.black.opacity(0.8))
                    //.padding()
                Button("Register Now") {
                    
                }
                    .bold()
                    .foregroundColor(.blue)
                    //.padding()
               
                
                
                
                
                
            }
            .sheet(isPresented: $showCreatAccount, content: {
                CreateAccount()
            })
            .navigationTitle("Sign In")
            
        }
        
        
        
    }
        
        
    }


    
    #Preview{
        SignIn()
            }
