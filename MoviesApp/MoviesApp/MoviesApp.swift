//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Yash Patil on 07/12/22.
//

import SwiftUI

@main
struct MoviesApp: App {
    
    @StateObject var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
                
        }
    }
}

