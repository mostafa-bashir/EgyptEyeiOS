//
//  Base.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import UIKit
import Alamofire


struct ImageWithName {
    var name:String
    var image:UIImage
}

struct FileWithName {
    var name:String
    var filePath:URL
}

class BaseAPI<T: TargetType> {
    func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {

        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }

        if rootVC?.presentedViewController == nil {
            return rootVC
        }

        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }

            return getVisibleViewController(presented)
        }
        return nil
    }
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        NetworkManager.shared.listen()
        if let vc = getVisibleViewController(nil) {
            NetworkManager.shared.configureVC(vc: vc)

        }
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers, interceptor: CustomInterceptor()).responseJSON { (response) in
            print(response.request?.url as Any)
            print(response)
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                let error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey:"invalid status"])
                completion(.failure(error))
                return
            }
            print("Status Code is |\(statusCode)|")
            if statusCode == 200 {
                // Successful request
                guard let jsonResponse = try? response.result.get() else {
                    // ADD Custom Error
                    let error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey:"can't parse"])
                    completion(.failure(error))
                    return
                }
                print(response)
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: "com.example.error", code: 400, userInfo: [NSLocalizedDescriptionKey:"can't serialize"])
                    completion(.failure(error))
                    return
                }
                
                // Swifty json
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                    // ADD Custom Error
                    let error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey:"can not decode"])
                    completion(.failure(error))
                    return
                }
                completion(.success(responseObj))
            } else if statusCode == 201 {
                completion(.success(.none))
            } else {
                // ADD custom error base on status code 404 / 401 / 422
                if statusCode == 401{
                    let error = NSError(domain: "com.example.error", code: 401, userInfo: [NSLocalizedDescriptionKey:"UnAuthorized"])
                    completion(.failure(error))
                }else{
                    let error = NSError(domain: "com.example.error", code: 404, userInfo: [NSLocalizedDescriptionKey:"The given data is invalid"])
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    
    func fetchMultiPartData<M: Decodable>(target: T, images: [ImageWithName], responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        AF.upload(multipartFormData: { (multiPart) in
            
            for p in params.0 {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            
            for image in images {
                guard let imageCompressed = image.image.jpegData(compressionQuality: 0.4) else{return}
                print(image.image)
                multiPart.append(imageCompressed, withName: image.name, fileName: "img.jpg", mimeType: "image/jpg")
            }
//            for file in files {
//
//                print(file.filePath)
//                multiPart.append(file.filePath, withName: file.name, fileName: "video.mp4", mimeType: "video/mp4")
//            }
        }, to: "\(target.baseURL + target.path)", method: method, headers: headers).responseJSON { (response) in
            print("in progress")
            print(response.request?.url as Any)
            print("response \(response) .... ")
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                let error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey:"invalid status"])
                completion(.failure(error))
                return
            }
            print("Status Code is |\(statusCode)|")
            if statusCode == 200 {
                // Successful request
                guard let jsonResponse = try? response.result.get() else {
                    // ADD Custom Error
                    let error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey:"can't parse"])
                    completion(.failure(error))
                    return
                }
                print(jsonResponse)
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey:"can't serialize"])
                    completion(.failure(error))
                    return
                }
                
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                    // ADD Custom Error
                    let error = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey:"can not decode"])
                    completion(.failure(error))
                    return
                }
                
                completion(.success(responseObj))
            }else if statusCode == 201{
                completion(.success(.none))
            }else {
                // ADD custom error base on status code 404 / 401 / 422
                let error = NSError(domain: "com.example.error", code: 404, userInfo: [NSLocalizedDescriptionKey:"The given data is invalid"])
                
                completion(.failure(error))
            }
        }
    }
        
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
        
        switch task {
        
        case .requestPlain:
            return ([:], URLEncoding.default)
            
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
        
    }
    
    class func getAPIToken()->String?{
        let def = UserDefaults.standard
        return def.object(forKey: "UserToken") as? String
    }
    
    func decode(jwtToken jwt: String) -> [String: Any] {
        let segments = jwt.components(separatedBy: ".")
        return decodeJWTPart(segments[1]) ?? [:]
    }
    
    func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
    func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
              let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
            return nil
        }
        
        return payload
    }
}
