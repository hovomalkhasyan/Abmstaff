//
//  Model.swift
//  Abmstaff
//
//  Created by Hovo on 10/1/20.
//

import Foundation

struct Response<T:Codable>: Codable {
    let success: Bool
    let data: T
    let messages: [Message]
}

struct DataClass: Codable {
    let token, expireDate: String
    let id: Int
}

struct Message: Codable {
    let key: Int
    let value: String
}

struct DataList: Codable {
    let fatherName: String
    let gitLabID: String?
    let phone: String
    let address: String?
    let type, gender: Int
    let dateOfBirth: String
    let email: String
    let permissions: [Int]
    let privacyList: [String]
    let positionID: Int?
    let positionName, team: String
    let teamID: Int?
    let linkedinLink, instagramLink, facebookLink, secondPhone: String?
    let careerStartDate, employeeDate: String
    let id: Int
    let firstName, lastName: String
    let profilePhoto: String?
    
}

struct TeamList: Codable {
    let membersCount, projectsCount, id: Int
    let name: String
}

struct StaffList: Codable {
    let id: Int
    let firstName, lastName: String
    let profilePhoto: String?
}

struct ProjectList: Codable {
    let id: Int
    let name: String
    let image: String?
}

