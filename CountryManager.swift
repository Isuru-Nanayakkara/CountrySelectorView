//
//  CountryManager.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 2020-12-16.
//

import Foundation

public class CountryManager {
    public static let shared = CountryManager()
    
    private(set) var countries: [Country] = []
    
    private init() {
        let path = Bundle(for: Self.self).path(forResource: "countries", ofType: "json")!
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            countries = try JSONDecoder().decode([Country].self, from: data)
        } catch {
            fatalError("Failed to load countries")
        }
    }
    
    public var currentCountry: Country? {
        if let code = Locale.current.regionCode {
            return getCountry(fromCode: code)
        } else {
            return nil
        }
    }
    
    public func getCountry(fromCode code: String) -> Country? {
        return countries.filter { $0.code == code }.first
    }
}
