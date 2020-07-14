//
//  CPCountry.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 6/29/20.
//

import Foundation

public struct CPCountry {
    public let code: String
    public let callingCode: String
    public let flag: String?
    
    public var name: String {
        return (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: code) ?? ""
    }
}

extension CPCountry: Codable {
    
    enum CodingKeys: String, CodingKey {
        case code
        case callingCode = "calling_code"
        case flag
    }
    
}

extension CPCountry: CustomStringConvertible {
    
    public var description: String {
        return "\(name) \(flag ?? "") | \(callingCode)"
    }
    
}
