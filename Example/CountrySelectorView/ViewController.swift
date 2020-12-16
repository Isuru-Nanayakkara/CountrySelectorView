//
//  ViewController.swift
//  CountrySelectorView
//
//  Created by Isuru-Nanayakkara on 07/14/2020.
//  Copyright (c) 2020 Isuru-Nanayakkara. All rights reserved.
//

import UIKit
import CountrySelectorView

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    
    let countrySelectorViewController = CountrySelectorViewController()
    let pickerView = CountryPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        
        pickerView.pickerDelegate = self
        textField.inputView = pickerView
        
        countrySelectorViewController.selectorDelegate = self
        
        
        if let country = CountryManager.shared.currentCountry {
            pickerView.setCountry(byCode: country.code)
            countrySelectorViewController.setCountry(byCode: country.code)
            
            countryLabel.text = "\(country.flag ?? "")  \(country.name)  \(country.callingCode)"
        }
        
//        if let country = CountryManager.shared.getCountry(fromCode: "US") {
//            countryLabel.text = "\(country.flag ?? "")  \(country.name)  \(country.callingCode)"
//        }
    }
    
    @IBAction func didTapTableViewButton(_ sender: UIButton) {
        present(countrySelectorViewController, animated: true)
    }
    
}

extension ViewController: CountrySelectorViewControllerDelegate {
    
    func didSelectCountry(_ countrySelectorViewController: CountrySelectorViewController, country: Country) {
        print(country)
        countrySelectorViewController.dismiss(animated: true)
    }
    
}

extension ViewController: CountryPickerViewDelegate {
    
    func didPickCountry(_ country: Country) {
        textField.text = country.name
    }
    
}
