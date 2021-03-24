//
//  CharacterDetailVC.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-24.
//

import UIKit

class CharacterDetailVC: UIViewController {
    
    @IBOutlet weak var characterEpisodeTableView: UITableView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterStatus: UILabel!
    @IBOutlet weak var characterOrigin: UILabel!
    @IBOutlet weak var characterGender: UILabel!
    @IBOutlet weak var characterSpecies: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    var characterDetail: Character!
    
    var episodeController = EpisodeController()
    var episodeArray: [Episode] = []
    var episodeString: [String]!
    var idList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let characterDetail = characterDetail {
            
            characterName.text = characterDetail.name
            characterSpecies.text = characterDetail.species
            characterGender.text = characterDetail.gender
            characterStatus.text = characterDetail.status
            characterOrigin.text = characterDetail.origin["name"]
            self.characterImage.loadImage(fromURL: characterDetail.image)
            
            if characterStatus.text == "Alive" {
                characterStatus.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            } else if characterStatus.text == "Dead" {
                characterStatus.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            } else {
                characterStatus.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
            
            //get all episodes ids'
            episodeString = characterDetail.episodes
            calculateIds()
            fetchEpisodes()
        }
    }
    
    func fetchEpisodes() {
        episodeController.fetchCharacterEpisodes(idList: idList) { (episodeArray) in
            if let episodeArray = episodeArray {
                
                DispatchQueue.main.async {
                    self.episodeArray = episodeArray
                    self.characterEpisodeTableView.reloadData()
                }
            }
        }
    }
    func calculateIds() {
        for line in episodeString {
            let id = line.split(separator: "/")
            idList.append(String(id[4]))
        }
    }
}

extension CharacterDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Episodes starring them"
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell")
        
        let episodeInfo = episodeArray[indexPath.row]
        cell?.textLabel?.textColor = .white
        cell?.detailTextLabel?.textColor = .white
        cell?.textLabel?.text = episodeInfo.namee
        cell?.detailTextLabel?.text = episodeInfo.episodeCode
        
        return cell!
    }
}
