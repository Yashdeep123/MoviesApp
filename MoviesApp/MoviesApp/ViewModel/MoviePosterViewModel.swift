//
//  MoviePosterViewModel.swift
//  MoviesApp
//
//  Created by Yash Patil on 09/12/22.
//

import Foundation
import SwiftUI
import Combine

class MoviePosterViewModel : ObservableObject {
    
    
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    private let PosterService : MoviePosterService
    
    let movie : Movie
    
    init(movie: Movie) {
        
        self.movie = movie
        self.PosterService = MoviePosterService(movie: movie)
        self.isLoading = true
        addPostSubs()
    }
    
    func addPostSubs() {
        
        PosterService.$moviePoster
            .sink { (_) in
                print("Completion works in Poster View.")
                self.isLoading = false
            } receiveValue: { [weak self] (Image) in
                self?.image = Image
            }.store(in: &cancellables)

    }
}
