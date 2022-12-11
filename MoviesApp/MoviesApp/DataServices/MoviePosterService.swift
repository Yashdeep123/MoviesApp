//
//  MoviePosterService.swift
//  MoviesApp
//
//  Created by Yash Patil on 09/12/22.
//

import Foundation
import SwiftUI
import Combine

class MoviePosterService {
    
    @Published var moviePoster : UIImage? = nil
    
    private let fileManager = LocalFileManager()
    var MoviePosterSubs : AnyCancellable?
    private let folderName = "Movie_Posters"
    private let imageName : String
    private let movie : Movie
    
    init(movie: Movie) {
        
        self.movie = movie
        self.imageName = movie.title
        getMovieImageFromDirectory()
        getPoster()
        
    }
    
    
    func getMovieImageFromDirectory() {
        
        guard let savedPoster = fileManager.getImage(imageName: imageName, folderName: folderName)
        else {
            getPoster()
            print("Downloading Movie Poster!!!.")
            return }
        
        moviePoster = savedPoster
        
    }
    
    
    func getPoster() {
        
        guard let url = URL(string: movie.moviePoster) else {return }
        MoviePosterSubs = DownloadManager.downloadData(url: url)
            .tryMap({ (ImageData) -> UIImage? in
                 return UIImage(data: ImageData)
            })
            .sink(receiveCompletion: DownloadManager.handleCompletion
                  , receiveValue: { [weak self] returnedImage in
                
                guard let self = self,let returnedImage = returnedImage else {return }
                self.moviePoster = returnedImage
                self.MoviePosterSubs?.cancel()
                self.fileManager.saveImage(image: returnedImage, imageName: self.imageName, folderName: self.folderName)
            }
            )
    }
    
}
