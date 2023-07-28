//
//  UserDetailsView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 03/07/2023.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    var body: some View {
        ZStack {
            // bg
            Image("login-bg")
                .resizable()
            
            
            VStack(spacing: 20){
                Text(profileViewModel.profile?.firstName ?? "")
                    .padding()
                    .frame(width: 300)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    }
                
                Text((profileViewModel.profile?.lastName ?? ""))
                    .padding()
                    .frame(width: 300)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    }
                
                Text(profileViewModel.profile?.email ?? "")
                    .padding()
                    .frame(width: 300)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    }
            }
            
        }
        .foregroundColor(.black)
        .ignoresSafeArea()
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView()
    }
}
