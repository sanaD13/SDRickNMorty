//
//  ShowAllLocationsVC.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-24.
//

import UIKit

class ShowAllLocationsVC: UIViewController {
    
    @IBOutlet weak var allLocationTableView: UITableView!
    
    var locationPresenter: LocationPresenter = LocationPresenter(locationService: LocationController())
    var locationPagedData: Info?
    var locationArray = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Locations"
        
        //load locations
        locationPresenter.setViewDelegate(delegate: self)
        locationPresenter.loadLocations(next: nil)
        
    }
}

extension ShowAllLocationsVC: LocationViewDelegate {
    func displayLocations(locationList: [Location], info: Info) {
        self.locationPagedData = info
        self.locationArray.append(contentsOf: locationList)
        
        DispatchQueue.main.async {
            self.allLocationTableView.reloadData()
        }
    }  
}

extension ShowAllLocationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell")
        
        let locationInfo = locationArray[indexPath.row]
        cell?.textLabel?.textColor = .white
        cell?.detailTextLabel?.textColor = .white
        cell?.textLabel?.text = locationInfo.namel
        cell?.detailTextLabel?.text = locationInfo.type + ", " + locationInfo.dimension
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (locationArray.count - 1) {
            if let nextPageLink = locationPagedData?.next {
                locationPresenter.loadLocations(next: nextPageLink)
            }
        }
    }
    
}

