//
//  Country.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 2020-12-16.
//

import Foundation

public struct Country {
    public let code: String
    public let callingCode: String
    public let flag: String?
    
    public var name: String {
        return (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: code) ?? ""
    }
}

extension Country: Codable {
    
    enum CodingKeys: String, CodingKey {
        case code
        case callingCode = "calling_code"
        case flag
    }
    
}

extension Country: CustomStringConvertible {
    
    public var description: String {
        return "\(name) \(flag ?? "") | \(callingCode)"
    }
    
}
