//
//  User.swift
//  ToucheFinal
//
//  Created by Yooj on 2023/01/17.
//

import Foundation


// <<<<<<< 0206/EditMyProfileStorage/SKH
enum Nation: String, Codable {
    case None = "π"
    case UnitedStates = "πΊπΈ"
    case RepublicOfKorea = "π°π·"
    case France = "π«π·"
    case Espana = "πͺπΈ"
    case Canada = "π¨π¦"
    
    /*
    var nationality: String {
        switch self {
        case .None: return "Select your nation."
        case .UnitedStates: return "USA"
        case .RepublicOfKorea: return "Republic of Korea"
        case .France: return "France"
        case .Espana: return "EspaΓ±a"
        case .Canada: return "Canada"
        }
    }
    
    var flag: String {
        switch self {
        case .None: return "π"
        case .UnitedStates: return "πΊπΈ"
        case .RepublicOfKorea: return "π°π·"
        case .France: return "π«π·"
        case .Espana: return "πͺπΈ"
        case .Canada: return "π¨π¦"
        }
    }
     */
    
    var flag: String {
        switch self {
        case .None: return "Select Your Region"
        case .UnitedStates: return "United States"
        case .RepublicOfKorea: return "Republic of Korea"
        case .France: return "France"
        case .Espana: return "EspaΓ±a"
        case .Canada: return "Canada"
        }
    }
    
    /*
    var nationality: String {
        switch self {
        case .None: String = "π"
        case .UnitedStates: return "πΊπΈ"
        case .RepublicOfKorea: return "π°π·"
        case .France: return "π«π·"
        case .Espana: return "πͺπΈ"
        case .Canada: return "π¨π¦"
        }
    }
     */
}


//enum Nation: Codable {
//    case None
//    case RepublicOfKorea
//    case France
//    case UnitedStates
//    case Japan
//}


struct UserInfo: Codable {
    var userId: String
    var userNation: String
    //var userNation: Nation
    var userNickName: String
    var userProfileImage: String
    var userEmail: String
    var writtenComments: [String]
    var recentlyPerfumesId: [String]
}
