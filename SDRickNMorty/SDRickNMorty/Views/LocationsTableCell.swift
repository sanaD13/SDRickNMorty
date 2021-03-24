//
//  LocationsTableCell.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import UIKit

class LocationsTableCell: UITableViewCell {
    
    private var locationArray = [Location]()
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        locationCollectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureLocation(for locationArray: [Location]) {
        if locationArray.count > 0 {
            self.locationArray = locationArray
            self.locationCollectionView.reloadData()
        }
    }
}

extension LocationsTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let locationInfo = locationArray[indexPath.row]
        cell.configureLocation(for: locationInfo)
        
        return cell
    }
}
