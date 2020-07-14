//
//  CountryPickerRowView.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 6/29/20.
//

import UIKit

class CountryPickerRowView: UIView {
    
    lazy var flagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var country: CPCountry!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(country: CPCountry) {
        self.init(frame: .zero)
        
        self.country = country
        layoutViews()
    }
    
    private func layoutViews() {
        flagLabel.text = country.flag
        codeLabel.text = country.callingCode
        nameLabel.text = country.name
        
        addSubview(flagLabel)
        addSubview(codeLabel)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            flagLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            flagLabel.topAnchor.constraint(equalTo: topAnchor),
            flagLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            flagLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            
            codeLabel.topAnchor.constraint(equalTo: topAnchor),
            codeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            codeLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            codeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.17),
            
            nameLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: codeLabel.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
