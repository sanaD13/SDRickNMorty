//
//  CollectionCell.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    func configureEpisode(for cellInfo: Episode) {
        self.cellImage.image = UIImage.init(named: "episode" + String(Int.random(in: 1...5)))
        //        self.cellImage.loadImage(fromURL: cellInfo.image)
        self.cellTitle?.text = cellInfo.namee
    }
    func configureCharacter(for cellInfo: Character) {
        self.cellImage.loadImage(fromURL: cellInfo.image)
        self.cellTitle?.text = cellInfo.name
    }
    func configureLocation(for cellInfo: Location) {
        self.cellImage.image = UIImage.init(named: "location" + String(Int.random(in: 1...5)))
        //        self.cellImage.loadImage(fromURL: cellInfo.image)
        self.cellTitle?.text = cellInfo.namel
    }
}
