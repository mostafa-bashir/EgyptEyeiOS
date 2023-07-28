//
//  FavoriteViewModel.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 06/07/2023.
//

import Foundation

class FavoriteViewModel: ObservableObject{
    
    @Published var landmarks: [LandmarkResult] = []
    
    init(){
        getFavorite()
    }
    
    func getFavorite(){
        AuthAPIs().getFavorite { result in
            switch result {
            case .success(let success):
                self.landmarks = success?.landmark ?? []
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
