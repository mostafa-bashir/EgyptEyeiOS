//
//  HistoryViewModel.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 05/07/2023.
//

import Foundation

class HistoryViewModel: ObservableObject{
    
    @Published var landmarks: [LandmarkResult] = []
    
    init(){
        getHistory()
    }
    
    func getHistory(){
        AuthAPIs().getHistory { result in
            switch result {
            case .success(let success):
                self.landmarks = success?.landmark ?? []
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
