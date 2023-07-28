//
//  ProfileViewModel.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 03/07/2023.
//

import Foundation

class ProfileViewModel: ObservableObject{
    @Published var profile: Profile?
    
    init() {
        getProfile()
    }
    
    func getProfile(){
        AuthAPIs().getProfile { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let value):
                self.profile = value
            }
        }
    }
}
