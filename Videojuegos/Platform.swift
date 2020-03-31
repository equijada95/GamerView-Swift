//
//  Platform.swift
//  Videojuegos
//
//  Created by MIMO on 27/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

struct Platform : Codable{
    var id : Int
    var name: String
    
    enum CodingKeys : String, CodingKey{
    case id = "id"
    case name = "name"
    }
}
