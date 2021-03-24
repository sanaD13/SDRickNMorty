//
//  LocationPresenter.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-24.
//

import Foundation

protocol LocationViewDelegate: NSObjectProtocol {
    func displayLocations(locationList: [Location], info: Info)
}

class LocationPresenter {
    weak private var delegate: LocationViewDelegate?
    private var locationService: LocationController
    
    init(locationService: LocationController) {
        self.locationService = locationService
    }
    
    func setViewDelegate(delegate: LocationViewDelegate) {
        self.delegate = delegate
    }
    
    func loadLocations(next: String?) {
        locationService.fetchMultipleLocations(url: next, queries: nil) { [weak self] (location) in
            
            guard let strongSelf = self else { return }
            
            if let location = location {
                strongSelf.delegate?.displayLocations(locationList: location.results, info: location.info)
            }
        }
    }
}
