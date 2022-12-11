//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Yash Patil on 07/12/22.

import Foundation
import Combine
import SwiftUI

class HomeViewModel : ObservableObject {
    
    @Published var isLoading : Bool = true
    @Published var ShowOverview : Bool = false
    @Published var storedMovies : [Movie] = []
    @Published var movies : [Movie] = []
    
    private let MoviesDataServices = MoviesDataService()
    private var cancellables = Set<AnyCancellable>()
    private let CoreDataSavedMovies = CoreDataViewModel()
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // Updates all the movies
        MoviesDataServices.$movies
            .sink { [weak self] (returnedMovies) in
                
                self?.movies = returnedMovies
            }
            .store(in: &cancellables)
        
        // Stores Movies into Core Data
        
        $movies
            .combineLatest(CoreDataSavedMovies.$savedMovies)
            .map(mapMoviesToCoreData)
            .sink { [weak self] storedMovies in
                self?.storedMovies = storedMovies
            }
            .store(in: &cancellables)
            
    }
    
    func reloadData() {
        MoviesDataServices.nextURL = "https://task.auditflo.in/2.json"
        MoviesDataServices.getMovies()
    }
    
    
    func updateMoviesFromCoreData(movies:[Movie]) {
        CoreDataSavedMovies.addMovies(movies:movies)
        
    }
    
    func mapMoviesToCoreData(movies:[Movie],savedMovies:[MovieEntity]) -> [Movie] {
        
        savedMovies
            .compactMap {
                movieEntity -> Movie? in
           
            guard let movie = movies.first(where: {
                $0.title == movieEntity.title &&
                $0.year == movieEntity.year  &&
                $0.summary == movieEntity.summary
            }) else {return nil}
               
            return movie
        }
       
    }
}
