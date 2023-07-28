//
//  ResultViewModel.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 03/07/2023.
//

import Foundation
import SwiftUI

class ResultViewModel: ObservableObject{
    @Published var result: LandmarkResult?
    @Published var shouldShowImage = false
    @Published var removeLike = false

    
    func getResult(id: String){
        AuthAPIs().getResult(id: id) { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let value):
                self.result = value?.landmark
                
            }
        }
    }
    
    func addFav(id: String){
        AuthAPIs().addFavorite(id: id) { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let value):
                    print(value)
            }
        }
        removeLike = true
    }
    
    func replaceSpacesInURL() -> String {
        let replacedString = result?.image?.image.replacingOccurrences(of: " ", with: "%20") ?? ""
        return replacedString
    }
}

