//
//  ViewController.swift
//  Sample
//
//  Created by Ahd on 4/14/20.
//  Copyright © 2020 ahd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func didClickInsertData(_ sender: Any) {
        let palestine = CountryModel.init();
        palestine.name = "Palestine";
        palestine.area = 27000;
        palestine.code = "PS";
        palestine.callingCode = "+972"
        palestine.id = "0"
        palestine.population = 5051953
        palestine.save();
        
        
        let lebanon = CountryModel.init();
        lebanon.name = "Lebanon";
        lebanon.area = 10452;
        lebanon.code = "LB";
        lebanon.callingCode = "+972"
        lebanon.population = 10452;
        lebanon.id = "1";
        lebanon.save()
        
        let ramallah = CityModel.init();
        ramallah.name = "Ramallah";
        ramallah.population = 27092;
        ramallah.isCapital = false;
        ramallah.country = palestine
        ramallah.id = "0"
        ramallah.save();
        
        let akka = CityModel.init();
        akka.name = "Akka";
        akka.population = 46300;
        akka.isCapital = false;
        akka.country = palestine
        akka.id = "1"
        akka.save();
        
        let jerusalem = CityModel.init();
        jerusalem.name = "Jerusalem";
        jerusalem.population = 27092;
        jerusalem.isCapital = true;
        jerusalem.country = palestine
        jerusalem.id = "2"
        jerusalem.save();
        
        let beirut = CityModel.init();
        beirut.name = "Beirut";
        beirut.population = 361366;
        beirut.isCapital = true;
        beirut.country = lebanon
        beirut.id = "3"
        beirut.save();
        
        let tyre = CityModel.init();
        tyre.name = "Tyre";
        tyre.population = 60000;
        tyre.isCapital = false;
        tyre.country = lebanon
        tyre.id = "4"
        tyre.save();
        
        let ramla = CityModel.init();
        ramla.name = "Ramla";
        ramla.population = 46300;
        ramla.isCapital = false
        ramla.country = palestine
        ramla.id = "5"
        ramla.save();

    }
    
}

