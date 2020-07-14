//
//  CountryListViewController.swift
//  CountrySelectorView
//
//  Created by Isuru Nanayakkara on 6/29/20.
//

import UIKit

public class CountryListViewController: UIViewController {
    
    private let collation = UILocalizedIndexedCollation.current()
    private let cellIdentifier = "CountryCell"
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    lazy private var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = false
        return searchController
    }()
    
    private var countries: [CPCountry] = []
    private var filteredCountries: [CPCountry] = []
    public var delegate: CountrySelectorViewControllerDelegate?
    public var selectedCountryCode: String?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        loadCountries()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        setupTableView()
        setupSearchController()
        scrollToInitialSelectedCountry()
    }
    
    private func setupView() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissViewController))
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func scrollToInitialSelectedCountry() {
        if let code = selectedCountryCode, let index = countries.firstIndex(where: { $0.code.lowercased() == code.lowercased() }) {
            tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
        }
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
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

extension CountryListViewController: UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return groupedCountries.count
//    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = searchController.isActive ? filteredCountries.count : countries.count
        return count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return collation.sectionTitles[section]
//    }
//
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return collation.sectionIndexTitles
//    }
//
//    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        return collation.section(forSectionIndexTitle: index)
//    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        
        let country = searchController.isActive ? filteredCountries[indexPath.row] : countries[indexPath.row]
        cell.textLabel?.text = "\(country.flag ?? "")  \(country.name)"
        cell.detailTextLabel?.text = country.callingCode
        
        if country.code.lowercased() == selectedCountryCode?.lowercased() {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
}

extension CountryListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = searchController.isActive ? filteredCountries[indexPath.row] : countries[indexPath.row]
        selectedCountryCode = country.code
        delegate?.didSelectCountry(navigationController as! CountrySelectorViewController, country: country)
    }
    
}

extension CountryListViewController: UISearchResultsUpdating {
    
    public func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredCountries.removeAll()
            return
        }
        
        filteredCountries = countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
}

extension CountryListViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchController.isActive = false
            filteredCountries.removeAll()
            tableView.reloadData()
        }
    }
    
}
