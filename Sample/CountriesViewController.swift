//
//  CountriesViewController.swift
//  Sample
//
//  Created by Ahd on 4/28/20.
//  Copyright © 2020 ahd. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries = [CountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad();

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.searchBar.delegate = self
        self.reloadData();
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.reloadData();
    }
    func reloadData() {
        let searchText = self.searchBar.text;
        if searchText!.count > 0  {
            //TODO: call search country query
            countries = CDQueriesManager.shared.queryCountryList(name: searchText!)!
            
        } else {
            //TODO: call get country list query
            countries = CDQueriesManager.shared.queryCountryList();
            
        }

        self.tableView.reloadData();
    }
    
    //MARK: -  UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let city = countries[indexPath.row];
        cell.textLabel?.text = city.name;
        return cell;
    }

    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.reloadData();
    }

}
