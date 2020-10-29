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

struct Message: Codable {
    let key: Int
    let value: String?
}

struct DataList: Codable {
    let fatherName: String?
    let gitLabID: String?
    let phone: String
    let address: String?
    let type, gender: Int
    let dateOfBirth: String
    let email: String
    let permissions: [Int]
    let privacyList: [Int]?
    let positionID: Int?
    let positionName, team: String
    let teamId: Int?
    let linkedinLink, instagramLink, facebookLink, secondPhone: String?
    let careerStartDate, employeeDate: String
    let id: Int
    let firstName, lastName: String
    let profilePhoto: String?
    
    var fullName: String {
        return firstName + " " + " " + lastName 
    }
}

struct DataClass: Codable {
    let token, expireDate: String
    let id: Int
}

// MARK: - TeamList
struct TeamList: Codable {
    let membersCount, projectsCount, id: Int
    let name: String
}

// MARK: - StaffList

struct StaffList: Codable {
    let id: Int
    let firstName, lastName: String
    let profilePhoto: String?
}

// MARK: - ProjectList

struct ProjectList: Codable {
    let id: Int
    let name: String
    let image: String?
}

// MARK: - UserDetailsID

struct UserDetailsId: Codable {
    let fatherName: String?
    let accountNumber : String?
    let phone: String?
    let address: String?
    let gender: Int
    let dateOfBirth : String?
    let employeeDate : String?
    let blockDate: String?
    let email: String
    let isBlocked: Bool
    let gitLabID, roleID: String?
    let roleName: String?
    let linkedinLink, instagramLink, facebookLink, note: String?
    let secondPhone, careerStartDate: String?
    let team: String?
    let teamID, positionID: String?
    let positionName: String?
    let technologies: [Technology]
    let projects : [Project]?
    let files: [String]
    let id: Int
    let firstName, lastName: String
    let profilePhoto: String?
    
    var fullName: String {
        return firstName + " " + " " + lastName 
    }
}

struct Project: Codable {
    let projectID: Int?
    let projectName: String?
    let platformID: Int?
    let platformName: String?

}

struct Technology: Codable {
    let id: Int
    let name: String
    let type: Int
}
// MARK: - TeamDetailsID
struct TeamDetailsID: Codable {
    let members: [Member]
    let projects: [TeamProject]?
    let id: Int
    let name: String
}

struct Member: Codable {
    let isLead: Bool
    let position: String?
    let id: Int
    let firstName, lastName: String
    let profilePhoto: String?
    var fullName : String {
        return firstName + " " + lastName
    }
}
struct TeamProject: Codable {
    let id: Int
    let name: String
    let image: String?
}

// MARK: - ProjectDetailsID

struct ProjectDetailsID: Codable {
    let deadLineDate: String?
    let projectStatus: Int
    let note: String?
    let createdBy: Int
    let appleAccountLogin, appleAccountPassword, googleAccountLogin, googleAccountPassword: String?
    let partnerID: String?
    let teamID: Int?
    let teamName: String?
    let members: [DetailMember]
    let platforms: [Platform]
    let createdDt: String
    let id: Int
    let name: String
    let image: String?

}

struct DetailMember: Codable {
    let platformIDS: [Int]?
    let position: String
    let id: Int
    let firstName, lastName: String
    let profilePhoto: String?

}

struct Platform: Codable {
    let id: Int
    let name: String
    let gitLabRepoID: String?
    let technologyID: Int?
    let gitURL, gitDeployToken, gitDeployUsername: String?

}
// MARK: - SettingsPlatform
struct SettingsPlatform: Codable {
    let membersCount, id: Int
    let name: String
}

// MARK: - SettingsPlatform
struct Platforms: Codable {
    let membersCount, id: Int
    let name: String
    let type: Int
}

// MARK: - Partners

struct Partners: Codable {
    let id: Int
    let companyName: String
    let logo: String?
}

// MARK: - PartnersDetails
struct PartnerDetails: Codable {
    let taxID, note, website, linkedinLink: String?
    let instagramLink, facebookLink, fax: String?
    let country: String
    let city, address, timezone: String?
    let email: String?
    let projects: [PartnerProject]
    let id: Int
    let companyName: String
    let logo: String?
    
}

struct PartnerProject: Codable {
    let id: Int
    let name: String
    let image: String?
}
// MARK: - AllStaffDetails
struct AllStaffDetails : Codable {
    let fatherName, accountNumber, phone, address: String?
    let gender: Int?
    let dateOfBirth, employeeDate: String?
    let email: String
    let gitLabID, roleID: Int?
    let linkedinLink, instagramLink: String?
    let facebookLink: String?
    let note: String?
    let secondPhone: String?
    let careerStartDate: String?
    let teamID, positionID: Int?
    let technologies: [Int]
    let id: Int
    let firstName, lastName: String
    let profilePhoto: String?
    
    var fullName: String{
        return firstName + " " + lastName
    }
}
