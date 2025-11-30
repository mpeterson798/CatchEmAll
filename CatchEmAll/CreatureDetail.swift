//
//  CreatureDetail.swift
//  CatchEmAll
//
//  Created by Matthew Peterson on 11/30/25.
//

import Foundation

@Observable  // Will watch objects for changes so that SwiftUI will redraw the interface when needed

class CreatureDetail {
    
    var urlString = "" //Update with string passed in from creature clicked on
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    
    private struct Returned: Codable {
        var height: Double
        var weight: Double
        var sprites: Sprite
    }
    
    struct Sprite: Codable {
        var front_default: String
    }
    
  
    
    func getData() async {
        print("🕸️ We are accessing the url \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                return
            }
            self.height = returned.height
            self.weight = returned.weight
            self.imageURL = returned.sprites.front_default
            
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
}
