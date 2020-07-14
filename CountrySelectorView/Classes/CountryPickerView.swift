//
//  CountryPickerView.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 6/29/20.
//

import UIKit

public class CountryPickerView: UIPickerView {
    
    private var countries: [CPCountry] = []
    public weak var pickerDelegate: CountryPickerViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        setup()
        loadCountries()
    }
    
    private func loadCountries() {
        let path = Bundle(for: Self.self).path(forResource: "countries", ofType: "json")!
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let countries = try JSONDecoder().decode([CPCountry].self, from: data)
            
            self.countries = countries
        } catch {
            fatalError("Failed to load countries")
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
