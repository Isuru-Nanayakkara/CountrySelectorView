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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        
        let pickerView = CountryPickerView()
        pickerView.pickerDelegate = self
//        pickerView.setCountry(byCode: "LK")
        textField.inputView = pickerView
    }
    
    @IBAction func didTapTableViewButton(_ sender: UIButton) {
        let countrySelectorViewController = CountrySelectorViewController()
        countrySelectorViewController.selectorDelegate = self
//        countrySelectorViewController.setCountry(byCode: "LK")
        present(countrySelectorViewController, animated: true)
    }
    
}

extension ViewController: CountrySelectorViewControllerDelegate {
    
    func didSelectCountry(_ countrySelectorViewController: CountrySelectorViewController, country: CPCountry) {
        print(country)
        countrySelectorViewController.dismiss(animated: true)
    }
    
}

extension ViewController: CountryPickerViewDelegate {
    
    func didPickCountry(_ country: CPCountry) {
        textField.text = country.name
    }
    
}
