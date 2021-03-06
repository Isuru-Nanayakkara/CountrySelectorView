//
//  CountryPickerViewControllerDelegate.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 6/29/20.
//

public protocol CountrySelectorViewControllerDelegate: class {
    func didSelectCountry(_ countrySelectorViewController: CountrySelectorViewController, country: Country)
}

public protocol CountryPickerViewDelegate: class {
    func didPickCountry(_ country: Country)
}
