//
//  ShowAllCharactersVC.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-24.
//

import UIKit

class ShowAllCharactersVC: UIViewController {
    
    @IBOutlet weak var allResultsCollectionView: UICollectionView!
    
    var characterPresenter: CharacterPresenter = CharacterPresenter(characterService: CharacterController())
    var characterPagedData: Info?
    var charactersArray = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Characters"
        
        //assign custom cell Nib
        allResultsCollectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        
        
        //load characters
        characterPresenter.setViewDelegate(delegate: self)
        characterPresenter.loadCharacters(next: nil)
    }
}

extension ShowAllCharactersVC: CharacterViewDelegate {
    func displayCharacters(characterList: [Character], resultInfo: Info) {
        characterPagedData = resultInfo
        self.charactersArray.append(contentsOf: characterList)
        
        DispatchQueue.main.async {
            self.allResultsCollectionView.reloadData()
        }
    }
}

extension ShowAllCharactersVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let characterInfo = charactersArray[indexPath.row]
        cell.configureCharacter(for: characterInfo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (charactersArray.count - 1) {
            if let nextPageLink = characterPagedData?.next {
                characterPresenter.loadCharacters(next: nextPageLink)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showCharacterDetail", sender: charactersArray[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacterDetail" {
            let characterInfo = sender as! Character
            let destination = segue.destination as! CharacterDetailVC
            destination.characterDetail = characterInfo
        }
    }
}

