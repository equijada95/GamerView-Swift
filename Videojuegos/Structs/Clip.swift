//
//  Clip.swift
//  Videojuegos
//
//  Created by MIMO on 13/04/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

struct Clip : Codable
{
    var clip: String
    
    enum CodingKeys : String, CodingKey{
    case clip = "clip"
    }
}
