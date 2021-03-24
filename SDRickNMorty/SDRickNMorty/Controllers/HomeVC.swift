//
//  HomeVC.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var HometableView: UITableView!
    
    //character
    var characterPresenter: CharacterPresenter = CharacterPresenter(characterService: CharacterController())
    var charactersArray: [Character] = []
    
    //episode
    var episodePresenter: EpisodePresenter = EpisodePresenter(episodeService: EpisodeController())
    var episodesArray: [Episode] = []
    
    //location
    var locationPresenter: LocationPresenter = LocationPresenter(locationService: LocationController())
    var locationsArray: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load episodes
        episodePresenter.setViewDelegate(delegate: self)
        episodePresenter.loadEpisodes(next: nil)
        
        //load characters
        characterPresenter.setViewDelegate(delegate: self)
        characterPresenter.loadCharacters(next: nil)
        
        //load locations
        locationPresenter.setViewDelegate(delegate: self)
        locationPresenter.loadLocations(next: nil)
        
    }
}

extension HomeVC: CharacterViewDelegate, EpisodeViewDelegate, LocationViewDelegate {
    func displayLocations(locationList: [Location], info: Info) {
        self.locationsArray = locationList
        
        DispatchQueue.main.async {
            self.HometableView.reloadData()
        }
    }
    
    func displayEpisodes(episodeList: [Episode], info: Info) {
        self.episodesArray = episodeList
        
        DispatchQueue.main.async {
            self.HometableView.reloadData()
        }
    }
    
    func displayCharacters(characterList: [Character], resultInfo: Info) {
        self.charactersArray = characterList
        
        DispatchQueue.main.async {
            self.HometableView.reloadData()
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 400 : 220
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesTableCell", for: indexPath) as! EpisodesTableCell
            cell.configureEpisode(for: episodesArray)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableCell", for: indexPath) as! CharactersTableCell
            cell.setClickDelegate(delegate: self)
            cell.configureCharacter(for: charactersArray)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsTableCell", for: indexPath) as! LocationsTableCell
            cell.configureLocation(for: locationsArray)
            return cell
        default:
            print("No Row available")
        }
        
        return UITableViewCell()
    }
}

extension HomeVC: CharacterClickDelegate {
    
    func showCharacterDetail(character: Character) {
        performSegue(withIdentifier: "showCharacterDetail", sender: character)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacterDetail" {
            let characterInfo = sender as! Character
            let destination = segue.destination as! CharacterDetailVC
            destination.characterDetail = characterInfo
        }
    }
}
