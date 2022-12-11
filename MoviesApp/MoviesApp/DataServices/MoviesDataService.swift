//
//  MoviesDataService.swift
//  MoviesApp
//
//  Created by Yash Patil on 07/12/22.
//

import Foundation
import Combine

class MoviesDataService :ObservableObject {
    
    @Published var movies : [Movie] = []
    @Published var nextURL : String = "https://task.auditflo.in/1.json"
    var MoviesSubscription : AnyCancellable?

    init() {
     getMovies()
    }
    
     func getMovies() {
        guard let url = URL(string: nextURL) else {return }
    
        MoviesSubscription = DownloadManager.downloadData(url: url)
            .decode(type: MovieModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: DownloadManager.handleCompletion, receiveValue: { [weak self] (returnedModel) in
                self?.movies = returnedModel.movies
                self?.MoviesSubscription?.cancel()
            })
        
    }
    
}

