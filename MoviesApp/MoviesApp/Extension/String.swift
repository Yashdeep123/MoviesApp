//
//  String.swift
//  MoviesApp
//
//  Created by Yash Patil on 10/12/22.
//

import Foundation
extension String {
    
    var removedDivider : String {
        self.replacingOccurrences(of: "|", with: "\n")
    }
}
