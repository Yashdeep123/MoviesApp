//
//  DownloadManager.swift
//  MoviesApp
//
//  Created by Yash Patil on 07/12/
import Foundation
import Combine

class DownloadManager {
    
    enum NetworkFailure: LocalizedError {
        case badURLResponse(url : URL)
        case unknown
        
        var localizedError : String? {
            switch self {
            case .badURLResponse(url: let url) : return "Bad URL Response from the server for url: \(url)"
            case .unknown : return "Unexpected error occured during the process"
            }
        }
    }
       
    static func downloadData(url : URL) -> AnyPublisher<Data,Error> {
        
        URLSession.shared.dataTaskPublisher(for:url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap {
                try handleResponse(output: $0, url: url)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleResponse(output :URLSession.DataTaskPublisher.Output,url:URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse , response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkFailure.badURLResponse(url: url) }
        
          return  output.data
    }
    
    static func handleCompletion (completion:Subscribers.Completion<Error>) {
        switch completion {
            
        case .finished:
            break
        case .failure(let error):
            print("Handle Completion Failure.!! : \(error) ")
        }
    }
}
