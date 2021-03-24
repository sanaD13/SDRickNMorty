//
//  EpisodesTableCell.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import UIKit

class EpisodesTableCell: UITableViewCell {
    
    private var episodeArray = [Episode]()
    @IBOutlet weak var episodeCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        episodeCollectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureEpisode(for episodeArray: [Episode]) {
        if episodeArray.count > 0 {
            self.episodeArray = episodeArray
            self.episodeCollectionView.reloadData()
        }
    }
}

extension EpisodesTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let episodeInfo = episodeArray[indexPath.row]
        cell.configureEpisode(for: episodeInfo)
        
        return cell
    }
}
