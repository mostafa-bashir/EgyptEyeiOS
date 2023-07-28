//
//  LoginView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @State var toSignup = false
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
                    
                    TextField("", text: $loginViewModel.mail)
                        .placeholder(when: loginViewModel.mail.isEmpty) {
                                Text("Enter Email").foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10.0)
                        .padding()
                        .shadow(radius: 2)
                        .foregroundColor(.black)

                    VStack(alignment: .trailing) {
                        SecureField("", text: $loginViewModel.password)
                            .placeholder(when: loginViewModel.password.isEmpty) {
                                    Text("***").foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10.0)
                            .padding()
                            .shadow(radius: 2)
                            .foregroundColor(.black)

                        Text("Recover Password?")
                            .foregroundColor(.white)

                    }

                }
                
                
                VStack{
                    Button {
                        loginViewModel.loggin()
                    } label: {
                        Text("Signin")
                            .padding()
                            .frame(width: 300)
                            .background(Color(hex: "#20595C"))
                            .cornerRadius(10.0)
                            .padding()
                            .padding(.horizontal)
                            .shadow(radius: 2)
                            .foregroundColor(.white)

                    }

                    
                    
                    Button {
                        toSignup = true
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

                
                
                
            }
            .padding()
        }
        .ignoresSafeArea()
        
        .sheet(isPresented: $toSignup) {
            SignupView()
        }
        .fullScreenCover(isPresented: $loginViewModel.isLoggedin) {
            TabBarView()
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


extension Color {
    init?(hex: String) {
        let r, g, b: Double
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = Double((hexNumber & 0xFF0000) >> 16) / 255.0
                    g = Double((hexNumber & 0x00FF00) >> 8) / 255.0
                    b = Double(hexNumber & 0x0000FF) / 255.0
                    
                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }
        
        return nil
    }
}
