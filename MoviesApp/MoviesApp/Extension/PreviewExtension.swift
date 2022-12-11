//
//  PreviewExtension.swift
//  MoviesApp
//
//  Created by Yash Patil on 09/12/22.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev : DeveloperPreview {
        return DeveloperPreview.instance
    }
}


class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
     init() { }
    let movie = Movie(title: "The Redeemed and the Dominant: Fittest on Earth",
                      year: "2018",
                      summary: "In 2017 the fittest athletes on Earth took on the unknown and unknowable during four of the most intense days of competition in CrossFit Games history. \"The Redeemed and the Dominant: Fittest on Earth \" captures all the drama as top athletes resembling chiseled Grecian gods descend on Madison, Wisconsin, to face a series of trials. Hercules faced 12; they take on 13. Emotions run high as a throng of Australian athletes rise to the top. By the end of the competition, some learn tough lessons-that all that glitters isn't gold, or even bronze-and some learn that they're even stronger than they realized. The best among them enter the pantheon of CrossFit giants and earn the right to call themselves the \"Fittest on Earth.\"",
                      shortSummary:
                        "In 2017 the fittest athletes on Earth took on the unknown and unknowable during four of the most intense days of competition in CrossFit Games history. &quot;The Redeemed and the Dominant: ...",
                      genres: "Documentary",
                      imdbid: "tt8144778",
                      runtime: "119",
                      youTubeTrailer: "rlZ5MG-E2Ls",
                      rating: "7.1",
                      moviePoster: "https://picsum.photos/1280/720",
                      director: "Heber Cannon",
                      writers: "Heber Cannon",
                      cast: "Dave Castro|Justin Bergh")
}
