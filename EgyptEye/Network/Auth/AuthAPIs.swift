//
//  AuthAPIs.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import Foundation
import UIKit

protocol AuthProtocol {
    
    func login(email:String,password:String, completion: @escaping (Result<LoginUser?, NSError>) -> Void)
    func signup(firstName: String, lastName: String, email: String, password: String, phoneNumber: String, completion: @escaping (Result<LoginUser?, NSError>) -> Void)
    func getLandmarksByTextSearch(search: String, completion: @escaping (Result<Landmarks?, NSError>) -> Void)
    func getResult(id: String, completion: @escaping (Result<ResultLandmark?, NSError>) -> Void)
    func getProfile(completion: @escaping (Result<Profile?, NSError>) -> Void)
    func searchByImage(image: UIImage, completion: @escaping (Result<ResultLandmark?, NSError>) -> Void)
    func getHistory(completion: @escaping (Result<Histroy?, NSError>) -> Void)
    func getFavorite(completion: @escaping (Result<Histroy?, NSError>) -> Void)
    func addFavorite(id: String,completion: @escaping (Result<Histroy?, NSError>) -> Void)


}


class AuthAPIs: BaseAPI<AuthNetworking> ,AuthProtocol{
    func addFavorite(id: String, completion: @escaping (Result<Histroy?, NSError>) -> Void) {
        fetchData(target: .addFav(landmarkId: id), responseClass: Histroy.self) { result in
            completion(result)
        }
    }
    
    func getHistory(completion: @escaping (Result<Histroy?, NSError>) -> Void) {
        fetchData(target: .getHistory, responseClass: Histroy.self) { result in
            completion(result)
        }
    }
    
    func getFavorite(completion: @escaping (Result<Histroy?, NSError>) -> Void) {
        fetchData(target: .getFavorite, responseClass: Histroy.self) { result in
            completion(result)
        }
    }
    
    func searchByImage(image: UIImage, completion: @escaping (Result<ResultLandmark?, NSError>) -> Void) {
        fetchMultiPartData(target: .searchByImage(image: image), images: [ImageWithName(name: "image", image: image)], responseClass: ResultLandmark.self) { result in
            completion(result)
        }
    }
    
    func getResult(id: String, completion: @escaping (Result<ResultLandmark?, NSError>) -> Void) {
        fetchData(target: .getResult(id: id), responseClass: ResultLandmark.self) { result in
            completion(result)
        }
    }
    
    func getProfile( completion: @escaping (Result<Profile?, NSError>) -> Void) {
        fetchData(target: .getProfile, responseClass: Profile.self) { result in
            completion(result)
        }
    }
    
    func signup(firstName: String, lastName: String, email: String, password: String, phoneNumber: String, completion: @escaping (Result<LoginUser?, NSError>) -> Void) {
        fetchData(target: .signup(firstName: firstName, lastName: lastName, email: email, password: password, phoneNumber: phoneNumber), responseClass: LoginUser.self) { result in
            completion(result)
        }
    }
    
    
    func login(email: String, password: String, completion: @escaping (Result<LoginUser?, NSError>) -> Void) {
        fetchData(target: .login(email: email, password: password), responseClass: LoginUser.self) { result in
            completion(result)
        }
    }
    
    func getLandmarksByTextSearch(search: String, completion: @escaping (Result<Landmarks?, NSError>) -> Void) {
        fetchData(target: .getLandmarksByTextSearch(search: search), responseClass: Landmarks.self) { result in
            completion(result)
        }
    }

}





