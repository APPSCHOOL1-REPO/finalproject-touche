//
//  String+.swift
//  ToucheFinal
//
//  Created by μ‘°μμ§ on 2023/01/20.
//

import Foundation

extension String{
    func tenString() -> String {
        let endIndex = self.index(self.startIndex, offsetBy: 14)
        return String(self[...endIndex])
    }
    
    func stringss(num: Int) -> String {
        return String(self.prefix(num))
    }
    
    func flag() -> String {
        switch self {
        case "United States of America":
            return "πΊπΈ"
        case "Republic of Korea":
            return "π°π·"
        case "France":
            return "π«π·"
        case "EspaΓ±a":
            return "πͺπΈ"
        case "Canada":
            return "π¨π¦"
        default:
            return "π³οΈ"
        }
    }
    
    func isValidNickname() -> Bool {
        let regex = "^.*([a-zA-Z0-9])+.*$"
        let nickNameTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return nickNameTest.evaluate(with: self)
    }
}
