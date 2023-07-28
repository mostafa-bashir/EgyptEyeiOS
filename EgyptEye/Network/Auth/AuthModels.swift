//
//  AuthModels.swift
//  EgyptEye
//
//  Created by Mostafa Bashir on 26/06/2023.
//

import Foundation

// MARK: - LoginUser
struct LoginUser: Codable {
    let token: String
}

// MARK: - Landmarks
struct Landmarks: Codable {
    let landmarks: [Landmark]
}

// MARK: - Landmark
struct Landmark: Codable {
    let id: Int
    let title: String?
}

// MARK: - ResultLandmark
struct ResultLandmark: Codable {
    let landmark: LandmarkResult
}

// MARK: - LandmarkResult
struct LandmarkResult: Codable {
    let id: Int
    let title, description: String?
    let imageID, locationID: Int?
    let createdAt, updatedAt: String
    let image: ImageLandmark?
    let location: Location?

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case imageID = "image_id"
        case locationID = "location_id"
        case createdAt, updatedAt, image, location
    }
}

// MARK: - Image
struct ImageLandmark: Codable {
    let id: Int
    let image, createdAt, updatedAt: String
}

// MARK: - Location
struct Location: Codable {
    let id: Int
    let long, lat, createdAt, updatedAt: String
}

// MARK: - Profile
struct Profile: Codable {
    let id: Int
    let firstName, lastName: String?
    let type, email, password: String
    let phoneNumber: Int
    let createdAt, updatedAt: String
}

// MARK: - Histroy
struct Histroy: Codable {
    let landmark: [LandmarkResult]
}

// MARK: - Landmark
struct LandmarkH: Codable {
    let id: Int
    let title, description: String
    let imageID, locationID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, description
        case imageID = "image_id"
        case locationID = "location_id"
        case createdAt, updatedAt
    }
}

