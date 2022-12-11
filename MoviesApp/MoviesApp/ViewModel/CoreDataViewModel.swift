//
//  CoreDataViewModel.swift
//  MoviesApp
//
//  Created by Yash Patil on 10/12/22.
//

import Foundation
import CoreData

class CoreDataViewModel : ObservableObject {
    
    let container : NSPersistentContainer
    @Published var savedMovies : [MovieEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "MovieContainer")
        container.loadPersistentStores { (description,error) in
            if let error = error {
              print("Failed in loading the data due to error: \(error)")
            }else {
                print("Successfully loaded data from the container!!")
            }
        }
        fetchData()
    }
    
    func fetchData() {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        
        do {
           savedMovies = try container.viewContext.fetch(request)
        }catch let error {
            print("Error fetching the request : \(error)")
        }
    }
   

    
    func addMovies(movies:[Movie]) {
        
        for movie in movies {
            let entity = MovieEntity(context: container.viewContext)
            entity.title = movie.title
            entity.year = movie.year
            entity.summary = movie.summary
            applyChanges()
        }
      print("All movies stored in core data")
    }
   
    func applyChanges() {
        save()
        fetchData()
    }
    
   private func save() {
        
       do {
           try container.viewContext.save()
       }catch let error {
           print("Error saving the data : \(error)")
       }
    }

}
