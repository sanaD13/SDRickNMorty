//
//  EpisodePresenter.swift
//  SDRickNMorty
//
//  Created by Sana Desai on 2021-03-23.
//

import Foundation

protocol EpisodeViewDelegate: NSObjectProtocol {
    func displayEpisodes(episodeList: [Episode], info: Info)
}

class EpisodePresenter {
    weak private var delegate: EpisodeViewDelegate?
    private var episodeService: EpisodeController
    
    init(episodeService: EpisodeController) {
        self.episodeService = episodeService
    }
    
    func setViewDelegate(delegate: EpisodeViewDelegate) {
        self.delegate = delegate
    }
    
    func loadEpisodes(next: String?) {
        episodeService.fetchMultipleEpisodes(url: next, queries: nil) { [weak self] (episode) in
            
            guard let strongSelf = self else { return }
            
            if let episode = episode {
                strongSelf.delegate?.displayEpisodes(episodeList: episode.results, info: episode.info)
            }
        }
    }
}
