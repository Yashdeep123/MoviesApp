//
//  MoviePosterView.swift
//  MoviesApp
//
//  Created by Yash Patil on 09/12/22.


import SwiftUI

struct MoviePosterView: View {
    
    //@EnvironmentObject var envm : HomeViewModel
    @StateObject var vm : MoviePosterViewModel
    
    init(movie : Movie) {
        _vm = StateObject(wrappedValue: MoviePosterViewModel(movie: movie))
    }
    
    var body: some View {
       
        ZStack {
            if let image = vm.image {
                withAnimation(.linear(duration: 1.0)) {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        
                }
            } else if vm.isLoading {
                      
                ProgressView
            }
            else {
                Image(systemName: "questionmark")
                    
            }

        }
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterView(movie: dev.movie)
    }
}


extension MoviePosterView {
    
    private var ProgressView : some View {
        ZStack(alignment:.center) {
            RoundedRectangle(cornerRadius: 25)
                .frame(minWidth: 100 ,maxWidth: .infinity, minHeight: 90)
                
                .foregroundColor(.clear)
                .fixedSize(horizontal: true, vertical: true)
            
        }
    }
}
