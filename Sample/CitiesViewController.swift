//
//  CitiesViewController.swift
//  Sample
//
//  Created by Ahd on 4/28/20.
//  Copyright © 2020 ahd. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cites = [CityModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.allowsMultipleSelectionDuringEditing = false;

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
            //TODO: call search city query
            cites = CDQueriesManager.shared.queryCityList(name: searchText ?? "")!
        } else {
            //TODO: call get cities list query
            cites = CDQueriesManager.shared.queryCityList();
            
            
        }
        
        self.tableView.reloadData();
    }
    
    //MARK: -  TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cites.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let city = cites[indexPath.row];
        cell.textLabel?.text = city.name;
        return cell;
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let city = self.cites[indexPath.row]
            
            //TODO: delete city item
            city.delete();
            self.cites.remove(at: indexPath.row);
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }

    }
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.reloadData();
    }
    
}
