//
//  ProfileView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 03/07/2023.
//

import SwiftUI

struct ProfileView: View {
    @State var logout = false
    var body: some View {
        ZStack {
            // bg
            Image("login-bg")
                .resizable()
            
            
            VStack{
                Spacer()
                HStack{
                    Text("Profile")
                        .font(.largeTitle)
                    Spacer()
                }
                Spacer()
                
                VStack{
                    NavigationLink {
                        UserDetailsView()
                    } label: {
                        Text("Profile Details")
                    }
                    .padding()
                    .frame(width: 300)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "#20595C")!)
                    }
                    
                    NavigationLink {
                        FavoriteView()
                    } label: {
                        Text("Favorites")
                    }
                    .padding()
                    .frame(width: 300)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "#20595C")!)
                    }
                    
                    NavigationLink {
                        HistoryView()
                    } label: {
                        Text("History")
                    }
                    .padding()
                    .frame(width: 300)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "#20595C")!)
                    }
                    
                    Button {
                        UserDefaults.standard.removeObject(forKey: "token")
                        logout = true
                    } label: {
                        Text("Logout")
                    }
                    .padding()
                    .frame(width: 300)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "#20595C")!)
                    }

                }
                Spacer()
                Spacer()
            }
            .padding()
            .foregroundColor(.white)
            
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $logout) {
            LoginView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
