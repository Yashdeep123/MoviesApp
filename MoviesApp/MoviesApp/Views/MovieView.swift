//
//  MovieView.swift
//  MoviesApp
//
//  Created by Yash Patil on 09/12/22.
//

import SwiftUI

struct MovieView: View {
    let movie : Movie
    var body: some View {
        HStack(alignment:.top,spacing: 15) {
            MoviePosterView(movie: movie)
               .cornerRadius(10)
               .frame(width: 150)
            VStack(alignment:.leading,spacing:5) {
                Text(movie.title)
                    .bold()
                    .lineLimit(1)
                    .shadow(color: .white, radius: 10, x: 0, y: 0)
                Text(movie.shortSummary)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                HStack(alignment: .bottom,spacing: 10) {
                    Text(movie.StarRating)
                        .font(.subheadline)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }.fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieView(movie : dev.movie)
                
                .previewLayout(.sizeThatFits)
        }
    }
}
