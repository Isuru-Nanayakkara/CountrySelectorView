//
//  CountrySelectorViewController.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 6/29/20.
//

import UIKit

public class CountrySelectorViewController: UINavigationController {
    
    public weak var selectorDelegate: CountrySelectorViewControllerDelegate!
    public var whitelistCountries: [String]?
    public var blacklistCountries: [String]?
    private var selectedCountryCode: String!
    
    
    /// Show all countries
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Show only these countries (filter by country code. ex: US, GB, CA)
    public init(whitelist countries: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        whitelistCountries = countries
    }
    
    /// Do not show these countries (filter by country code. ex: US, GB, CA)
    public init(blacklist countries: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        blacklistCountries = countries
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let countryListViewController: CountryListViewController
        if let whitelist = whitelistCountries {
            countryListViewController = CountryListViewController(whitelist: whitelist)
        } else if let blacklist = blacklistCountries {
            countryListViewController = CountryListViewController(blacklist: blacklist)
        } else {
            countryListViewController = CountryListViewController()
        }
        
        countryListViewController.delegate = selectorDelegate
        countryListViewController.selectedCountryCode = selectedCountryCode
        
        viewControllers = [countryListViewController]
    }
    
    public func setCountry(byCode code: String) {
        selectedCountryCode = code
    }
    
}
