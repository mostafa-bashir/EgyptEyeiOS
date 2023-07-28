//
//  HistoryView.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 05/07/2023.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var histroyViewModel = HistoryViewModel()
    var body: some View {
        ZStack{
            // bg
            Image("login-bg")
                .resizable()
                .ignoresSafeArea()
           
            
            
            VStack{
                Spacer()
                HStack{
                    Text("History")
                        .font(.largeTitle)
                        .foregroundColor(.white)

                    Spacer()
                }
                Spacer()
                
                VStack{
                    
                    ForEach(histroyViewModel.landmarks, id: \.id) { landmark in
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
                    
                    Spacer()
                    
                }
                Spacer()
                Spacer()
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
