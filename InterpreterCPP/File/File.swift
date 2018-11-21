//
//  File.swift
//  InterpreterCPlusPlus
//
//  Created by Maxim Butin on 16/11/2018.
//  Copyright © 2018 Maxim Butin. All rights reserved.
//

import Foundation


public class File {
    let nameFile: String
    let nameExtension: String
    
    public init(nameFile: String, nameExtension: String) {
        self.nameFile = nameFile
        self.nameExtension = nameExtension
    }
    
    public func readFile() -> String {
        let home = FileManager.default.homeDirectoryForCurrentUser
        
        let projectUrl = home
            .appendingPathComponent("Documents/Учеба/МАТФЯ/SwiftInterpreterCPP/InterpreterCPP/InterpreterCPP/File")
            .appendingPathComponent(nameFile)
            .appendingPathExtension(nameExtension)
        
        var content = ""
        
        do {
            content = try String(contentsOfFile: projectUrl.path, encoding: .utf8)
        } catch let error as NSError {
            print("Failed to read file")
            print(error)
        }
        
        return content
    }
}
