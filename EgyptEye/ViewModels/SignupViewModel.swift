//
//  SignupViewModel.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import Foundation

class SignupViewModel: ObservableObject{
    @Published var isSignedup = false
    @Published var mail = ""
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var phonenumber = "02"
    @Published var password = ""

    
    func signup(){
        AuthAPIs().signup(firstName: firstname.description, lastName: lastname.description, email: mail.description, password: password.description, phoneNumber: phonenumber.description) { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let value):
                UserDefaults.standard.set(value?.token, forKey: "token")
                self.isSignedup = true
            }
        }
    }
}
