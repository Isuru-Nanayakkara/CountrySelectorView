//
//  CountryPickerView.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 6/29/20.
//

import UIKit

public class CountryPickerView: UIPickerView {
    
    private var countries: [Country] = []
    public weak var pickerDelegate: CountryPickerViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Show all countries
    convenience public init() {
        self.init(frame: .zero)
        
        setup()
        loadCountries()
    }
    
    /// Show only these countries (filter by country code. ex: US, GB, CA)
    convenience public init(whitelist countries: [String]) {
        self.init(frame: .zero)
        
        setup()
        loadCountries(whitelist: countries)
    }
    
    /// Do not show these countries (filter by country code. ex: US, GB, CA)
    convenience public init(blacklist countries: [String]) {
        self.init(frame: .zero)
        
        setup()
        loadCountries(blacklist: countries)
    }
    
    
    private func loadCountries(whitelist: [String]? = nil, blacklist: [String]? = nil) {
        let allCountries = CountryManager.shared.countries
        
        if let codes = blacklist {
            self.countries = allCountries.filter { !codes.contains($0.code) }
        } else if let codes = whitelist {
            self.countries = allCountries.filter { codes.contains($0.code) }
        } else {
            self.countries = allCountries
        }
    }
    
    private func setup() {
        dataSource = self
        delegate = self
    }
    
    public func setCountry(byCode code: String) {
        if let index = countries.firstIndex(where: { $0.code.lowercased() == code.lowercased() }) {
            selectRow(index, inComponent: 0, animated: true)
        }
    }
    
}

extension CountryPickerView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
}

extension CountryPickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let country = countries[row]
        return CountryPickerRowView(country: country)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countries[row]
        pickerDelegate?.didPickCountry(country)
    }
    
}
