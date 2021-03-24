//
//  ShowAllVC.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-24.
//

import UIKit

class ShowAllEpisodesVC: UIViewController {
    
    @IBOutlet weak var allEpisodesTableView: UITableView!
    
    var episodePresenter: EpisodePresenter = EpisodePresenter(episodeService: EpisodeController())
    var episodePagedData: Info?
    var episodeArray = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Episodes"
        
        //load episodes
        episodePresenter.setViewDelegate(delegate: self)
        episodePresenter.loadEpisodes(next: nil)
        
    }
}

extension ShowAllEpisodesVC: EpisodeViewDelegate {
    func displayEpisodes(episodeList: [Episode], info: Info) {
        self.episodePagedData = info
        self.episodeArray.append(contentsOf: episodeList)
        
        DispatchQueue.main.async {
            self.allEpisodesTableView.reloadData()
        }
    }
    
    
}

extension ShowAllEpisodesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (episodeArray.count - 1) {
            if let nextPageLink = episodePagedData?.next {
                episodePresenter.loadEpisodes(next: nextPageLink)
            }
        }
    }
    
}
