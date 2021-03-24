//
//  CharacterPresenter.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import Foundation

protocol CharacterViewDelegate: NSObjectProtocol {
    func displayCharacters(characterList: [Character], resultInfo: Info)
}

class CharacterPresenter {
    weak private var delegate: CharacterViewDelegate?
    private var characterService: CharacterController
    
    init(characterService: CharacterController) {
        self.characterService = characterService
    }
    
    func setViewDelegate(delegate: CharacterViewDelegate) {
        self.delegate = delegate
    }        
    
    func loadCharacters(next: String?) {
        characterService.fetchMultipleCharacters(url: next, queries: nil) { [weak self] (pagingInfo) in
            
            guard let strongSelf = self else { return }
            
            if let pagingInfo = pagingInfo {
                strongSelf.delegate?.displayCharacters(characterList: pagingInfo.results, resultInfo: pagingInfo.info)
            }
        }
    }
}
