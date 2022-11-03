//
//  FileManager.swift
//  Elene_Kapanadze_25
//
//  Created by Ellen_Kapii on 24.08.22.
//

import UIKit

class FileManagerHelper {
    
    static let shared = FileManagerHelper()
    
    var allUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    //MARK: - Creating and Loading  Directories
    
    
    func createDirectory(name: String) {
        
        allUrls!.appendPathComponent(name)
        do {
            try FileManager.default.createDirectory(at: allUrls!, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Couldn't Create Directory")
        }
    }
    
    func loadDirectories() -> Result<[String], Error> {
        
        let path = allUrls!.path
        
        do {
            
            let directories = try FileManager.default.contentsOfDirectory(atPath: path).filter { $0 != ".DS_Store" }
            return .success(directories)
            
        } catch {
            
            return .failure(error)
            
        }
        
    }
    
    
    //MARK: - Creating and Loading Remainders
    
    func createRemainder(name: String, currentDirectory: String, data: String) {
        
        allUrls!.appendPathComponent(currentDirectory)
        allUrls!.appendPathComponent("\(name).txt")
        
        let textData = data.data(using: .utf8)!
        
        FileManager.default.createFile(atPath: allUrls!.path, contents: textData)
    }
    
    
    func loadRemainders(currentDirectory: String) -> Result<[String: String], Error> {
        
        allUrls!.appendPathComponent(currentDirectory)
        
        let path = allUrls!.path
        
        do {
            
            let remainders = try FileManager.default.contentsOfDirectory(atPath: path).filter { $0 != ".DS_Store" }
            
            var remaindersDict = [String:String]()
            
            remainders.forEach { remainder in
                
                allUrls!.appendPathComponent(currentDirectory)
                allUrls!.appendPathComponent(remainder)
                
                guard let remainderData = FileManager.default.contents(atPath: allUrls!.path) else { return }
                
                let remainderTitle = remainder.replacingOccurrences(of: ".txt", with: "")
                let remainderBody = String(decoding: remainderData, as: UTF8.self)
                
                remaindersDict[remainderTitle] = remainderBody
            }
            
            return .success(remaindersDict)
            
        } catch {
            return .failure(error)
        }
        
    }
    
    
    
    
    
    
    
    
    
}
