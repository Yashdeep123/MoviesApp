//
//  ContentView.swift
//  MoviesApp
//
//  Created by Yash Patil on 07/12/22.
//

import SwiftUI

struct HomeView: View {
    
    
    @EnvironmentObject var vm : HomeViewModel
    
    
    @State var buttonPressed: Bool = false
    @State var showCheckMark : Bool = true
    @State var allMovies : [Movie] = []
    
    var body: some View {
       
        NavigationView  {
            ScrollView(.vertical,showsIndicators: true) {
                    VStack(spacing: 30) {
                        ForEach(allMovies.isEmpty ? vm.movies : vm.storedMovies,id: \.title) { movie in
                            
                            NavigationLink(destination: HomeDetailView(movie: movie)) {
                                MovieView(movie: movie)
                                    .foregroundColor(.black)
                            }
                            
                        }
                    }
            }
            .navigationTitle("Movies")
               
            
            .padding(.leading)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    HStack {
                        Button{
                         SaveButtonPressed()
                        } label: {
                            if !buttonPressed {
                                Text("Save")
                            }else {
                                HStack(spacing:0) {
                                    Text("Saved ").foregroundColor(.black)
                                    Image(systemName: "checkmark")
                                        .font(.callout)
                                        .foregroundColor(.black)
                                        .opacity(showCheckMark ? 1.0 : 0.0)
                                        
                                }
                            }
                        }
                        
                        Button("Reload") {
                            vm.reloadData()
                            buttonPressed = false
                            
                        }
                    }
                }
            }
        } 
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            HomeView()
               
                .environmentObject(HomeViewModel())
        
    }
}

extension HomeView {
    
    private  func SaveButtonPressed() {
        
        allMovies = vm.movies
        vm.updateMoviesFromCoreData(movies: allMovies)
        buttonPressed = true
        allMovies = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeIn) {
                showCheckMark = false
            }
            
        }
    }
}
