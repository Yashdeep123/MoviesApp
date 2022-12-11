//
//  LocalFileManager.swift
//  MoviesApp
//
//  Created by Yash Patil on 10/12/22.
//

import Foundation
import SwiftUI


class LocalFileManager {
    
    init() { }
    
    func saveImage(image : UIImage,imageName: String,folderName:String) {
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(),
              let url = getURLForImage(folderName: folderName, ImageName: imageName) else { return }
        
        do {
            try data.write(to: url)
        }catch let error {
            print("Error writing image Data to the Image url. : \(error)")
        }
    }
    
    func createFolderIfNeeded(folderName:String) {
        guard let url = getURLSForFolder(folderName: folderName) else {return}
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do { try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            }catch let error {
                print("Error creating directory in File Manager!. : \(error)")
            }
        }
    }
    
    func getImage(imageName:String,folderName :String) -> UIImage? {
        
        guard let url = getURLForImage(folderName: folderName, ImageName: imageName),FileManager.default.fileExists(atPath: url.path) else {
            print("Error fetching the image")
            return nil}
        return UIImage(contentsOfFile: url.path)
    }
    
    func getURLForImage(folderName:String,ImageName:String) -> URL? {
        guard let folderurl = getURLSForFolder(folderName: folderName) else {return nil}
        
        return folderurl.appendingPathComponent(ImageName + ".png")
    }
    
    func getURLSForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        return url.appendingPathComponent(folderName)
    }
}
