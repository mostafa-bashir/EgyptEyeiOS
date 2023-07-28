//
//  SignupView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import SwiftUI

struct SignupView: View {
    @StateObject var signupViewModel = SignupViewModel()
    var body: some View {
        ZStack{
//            bg
            Image("login-bg")
                .resizable()

            
            
//            content
            
            VStack{
                
                VStack{
                    Text("Welcome!")
                        .font(.largeTitle)
                    
                    TextField("", text: $signupViewModel.firstname)
                        .placeholder(when: signupViewModel.firstname.isEmpty) {
                                Text("First Name").foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10.0)
                        .padding()
                        .shadow(radius: 2)
                        .foregroundColor(.black)
                        
                    
                    TextField("", text: $signupViewModel.lastname)
                        .placeholder(when: signupViewModel.lastname.isEmpty) {
                                Text("Last Name").foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10.0)
                        .padding()
                        .shadow(radius: 2)
                        .foregroundColor(.black)
                        .accentColor(.gray)

                    
                    TextField("", text: $signupViewModel.mail)
                        .placeholder(when: signupViewModel.mail.isEmpty) {
                                Text("Enter Email").foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10.0)
                        .padding()
                        .shadow(radius: 2)
                        .foregroundColor(.black)
                        .accentColor(.gray)


                    SecureField("", text: $signupViewModel.password)
                        .placeholder(when: signupViewModel.password.isEmpty) {
                                Text("*****").foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10.0)
                        .padding()
                        .shadow(radius: 2)
                        .foregroundColor(.black)
                        .accentColor(.red)


                    }

                
                
                Button {
                    signupViewModel.signup()
                } label: {
                    Text("Register")
                        .padding()
                        .frame(width: 300)
                        .background(Color(hex: "#20595C"))
                        .cornerRadius(10.0)
                        .padding()
                        .padding(.horizontal)
                        .shadow(radius: 2)
                        .foregroundColor(.white)
                }

                
                
                
            }
            .padding()
        }
        .fullScreenCover(isPresented: $signupViewModel.isSignedup){TabBarView()}
        .ignoresSafeArea()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
