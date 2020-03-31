//
//  Search.swift
//  Videojuegos
//
//  Created by MIMO on 26/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

struct Search : Codable {
    
    var results : [Videogame]
    
    enum CodingKeys: String, CodingKey {
      case results = "results"
    }
}
