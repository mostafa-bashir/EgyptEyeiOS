//
//  LoginViewModel.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var isLoggedin = false
    @Published var mail = ""
    @Published var password = ""

    
    func loggin(){
        AuthAPIs().login(email: mail.description, password: password.description) { result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let value):
                UserDefaults.standard.set(value?.token, forKey: "token")
                self.isLoggedin = true
            }
        }
    }
}
