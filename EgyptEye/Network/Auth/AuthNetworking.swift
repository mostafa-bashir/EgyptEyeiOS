//
//  AuthNetworking.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import Foundation
import Alamofire
import UIKit

enum AuthNetworking: TargetType {

    case login(email:String,password:String)
    case signup(firstName:String,lastName:String,email:String,password:String,phoneNumber:String)
    case getLandmarksByTextSearch(search:String)
    case getResult(id: String)
    case getProfile
    case searchByImage(image: UIImage)
    case getHistory
    case getFavorite
    case addFav(landmarkId: String)

    
    var baseURL: String {
        return Constants.BaseURL
    }

    var path: String {
        switch self {


        case .login:
            return "apis/user/login"
        case .signup:
            return "apis/signup"
        case .getLandmarksByTextSearch(search: let search):
            return "search/landmark?search=\(search)"
        case .getResult(id: let id):
            return "search/getlandmark?id=\(id)"
        case .getProfile:
            return "profile"
        case .searchByImage:
            return "search/getlandmark/image"
        case .getHistory:
            return "search/gethistory"
        case .getFavorite:
            return "favorite/getfavorites"
        case .addFav:
            return "favorite/addfavorite"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getLandmarksByTextSearch:
            return .get
        case .getResult:
            return .get
        case .getProfile:
            return .get
        case .getHistory:
            return .get
        case .getFavorite:
            return .get
        default:
            return .post
        }
    }

    var task: Task {
        switch self {


        case .login(email: let email, password: let password):
            return .requestParameters(parameters: ["email":email,"password":password], encoding: JSONEncoding.default)
        case .signup(firstName: let firstName, lastName: let lastName, email: let email, password: let password, phoneNumber: let phoneNumber):
            return .requestParameters(parameters: ["email":email,"password":password, "firstName":firstName, "lastName":lastName, "phoneNumber":phoneNumber], encoding: JSONEncoding.default)
        case .getLandmarksByTextSearch:
            return .requestPlain
        case .getResult:
            return .requestPlain
        case .getProfile:
            return .requestPlain
        case .searchByImage(image: let image):
            return .requestParameters(parameters: ["image":image], encoding: JSONEncoding.default)
        case .getHistory:
            return .requestPlain
        case .getFavorite:
            return .requestPlain
        case .addFav(landmarkId: let landmarkId):
            return .requestParameters(parameters: ["landmark_id": landmarkId], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["authenticate": UserDefaults.standard.string(forKey: "token") ?? ""]
    }
}

