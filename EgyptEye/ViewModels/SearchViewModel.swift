//
//  SearchViewModel.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 27/06/2023.
//

import Foundation
import UIKit

class SearchViewModel: ObservableObject{
    @Published var searchTF = ""
    @Published var landmarks: [Landmark] = []
    @Published var image: UIImage?
    @Published var landmarkResult: LandmarkResult?
    @Published var gotResult = false
    @Published var isLoading = false
    @Published var showingToast = false
    
    func searchByText(){
        AuthAPIs().getLandmarksByTextSearch(search: searchTF.description) { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let value):
                self.landmarks = value?.landmarks ?? []
            }
        }
    }
    
    func searchByImage() {
        if let image = image {
            isLoading = true // Set isLoading to true before starting the image search

            AuthAPIs().searchByImage(image: image) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let success):
                    self.landmarkResult = success?.landmark
                    if self.landmarkResult != nil {
                        self.gotResult = true
                    }
                    self.image = nil

                case .failure(let failure):
                    print(failure)
                    self.image = nil
                    self.showingToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showingToast = false
                    }
                }

                self.isLoading = false // Set isLoading to false after the search is completed
            }
        }
    }

}
