//
//  FavoriteView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 06/07/2023.
//

import SwiftUI

struct FavoriteView: View {
    
    @StateObject var favoriteViewModel = FavoriteViewModel()
    var body: some View {
        ZStack{
            // bg
            Image("login-bg")
                .resizable()
                .ignoresSafeArea()
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            
            VStack{
                Spacer()
                HStack{
                    Text("Favorites")
                        .font(.largeTitle)
                        .foregroundColor(.white)

                    Spacer()
                }
                Spacer()
                
                VStack{
                    
                    ForEach(favoriteViewModel.landmarks, id: \.id) { landmark in
                        NavigationLink(destination: ResultFromImageView(landmark: landmark)) {
                                Text(landmark.title ?? "")
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 300)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                    }
                            }
                    }
                    
                    
                    
                }
                Spacer()
                Spacer()
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
