//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Yash Patil on 07/12/22.
//

import Foundation


struct MovieModel: Codable {
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movies = "Movie List"
    }
}

// MARK: - MovieList

struct Movie: Codable {
    let title, year, summary, shortSummary: String
    let genres, imdbid, runtime: String
    let youTubeTrailer: String?
    let rating: String
    let moviePoster: String
    let director, writers, cast: String

    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case summary = "Summary"
        case shortSummary = "Short Summary"
        case genres = "Genres"
        case imdbid = "IMDBID"
        case runtime = "Runtime"
        case youTubeTrailer = "YouTube Trailer"
        case rating = "Rating"
        case moviePoster = "Movie Poster"
        case director = "Director"
        case writers = "Writers"
        case cast = "Cast"
    }
    
    var StarRating: String {
        return self.rating + "/10"
    }
    var Runtime : String {
        return self.runtime + " min"
    }
    
    
}
