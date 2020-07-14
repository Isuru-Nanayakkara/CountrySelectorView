//
//  CountrySelectorViewController.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 6/29/20.
//

import UIKit

public class CountrySelectorViewController: UINavigationController {
    
    public weak var selectorDelegate: CountrySelectorViewControllerDelegate!
    private var selectedCountryCode: String!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let countryListViewController = CountryListViewController()
        countryListViewController.delegate = selectorDelegate
        countryListViewController.selectedCountryCode = selectedCountryCode
        
        viewControllers = [countryListViewController]
    }
    
    public func setCountry(byCode code: String) {
        selectedCountryCode = code
    }
    
}
