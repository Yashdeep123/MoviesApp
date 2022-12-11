//
//  HomeDetailView.swift
//  MoviesApp
//
//  Created by Yash Patil on 09/12/22.
//

import SwiftUI


struct HomeDetailView: View {
    
    @EnvironmentObject var vm : HomeViewModel
    let movie: Movie
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                VStack(alignment: .leading, spacing:80) {
                    MoviePosterView(movie: movie)
                        .position(x:195,y:160)
                        .padding(.top,-60)
                    
                    VStack(alignment: .leading,spacing: 20) {
                       
                        TitleView
                        LinkView

                        VStack(alignment:.leading,spacing: 10) {
                              
                            Overview
                            RatingView
                            
                            HStack(alignment:.top) {
                                CastView
                                Spacer()
                                DirectorView
                                
                            }
                            IMDBIDLink
                            
                        }
                        .padding(.leading)
                       
                        
                    }
                    
                }
            }
        }
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailView(movie: dev.movie)
            .environmentObject(HomeViewModel())
    }
}


extension HomeDetailView {
    
    private var TitleView :some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(movie.genres)
                Text("-")
                Text(movie.year)
                Text("-")
                Text(movie.Runtime)
            }
            
            
            Text(movie.title)
                .bold()
                .font(.title2)
            
        }.padding()
    }
    
    private var LinkView : some View {
        Link(destination: URL(string: "https://www.youtube.com/watch?v=\(movie.youTubeTrailer ?? "")")!) {
            Text("Watch Trailer")
        }
        .buttonStyle(.borderedProminent)
        .padding(.leading)
    }
    
    private var Overview : some View {
        VStack(alignment: .leading) {
            Text("Overview")
                .bold()
                .font(.title)
            
            Divider()
            Text(movie.summary)
                .lineLimit(vm.ShowOverview ? nil : 4)
            
            Button {
                withAnimation(.easeInOut) {
                    vm.ShowOverview.toggle()
                    print("Pressed")
                }
            }
        label: {
            Text(vm.ShowOverview ? "Show less" : "Read More...")
        }
        }
    }
    
    private var RatingView : some View {
        HStack(alignment: .bottom,spacing: 10) {
            Text("Rating : \(movie.StarRating)")
                .font(.subheadline)
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }
    }
    
    private var CastView : some View {
        VStack(alignment: .leading) {
            Text("Cast")
                .bold()
                .font(.title3)
            Divider()
            Text(movie.cast.removedDivider)
                .font(.callout)
        }
    }
    private var DirectorView : some View
    {
        VStack(alignment:.trailing) {
            Text("Director & Writer")
                .bold()
                .font(.title3)
               
                
            Divider()
            
            Text(movie.director)
                .font(.callout)
            Text(movie.writers)
                .font(.callout)
            
            
            
        }.padding(.trailing)
          .frame(maxWidth: .infinity)
    }
    
    private var IMDBIDLink : some View {
        Link(destination: URL(string: "https://www.imdb.com/title/\(movie.imdbid)/")!) {
            Text("IMDB")
                .bold()
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background {
                    Color.yellow
                }
                .cornerRadius(25)
                .foregroundColor(.black)
        }.frame(height: 100)
    }
}
