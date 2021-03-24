//
//  CharactersTableCell.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-24.
//

import UIKit

protocol CharacterClickDelegate: NSObjectProtocol {
    func showCharacterDetail(character: Character)
}

class CharactersTableCell: UITableViewCell {
    
    weak private var delegate: CharacterClickDelegate?
    private var characterArray = [Character]()
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        characterCollectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setClickDelegate(delegate: CharacterClickDelegate) {
        self.delegate = delegate
    }
    
    func configureCharacter(for characterArray: [Character]) {
        if characterArray.count > 0 {
            self.characterArray = characterArray
            self.characterCollectionView.reloadData()
        }
    }
}

extension CharactersTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let characterInfo = characterArray[indexPath.row]
        cell.configureCharacter(for: characterInfo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.showCharacterDetail(character: characterArray[indexPath.row])
    }
}

