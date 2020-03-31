//
//  Platforms.swift
//  Videojuegos
//
//  Created by MIMO on 27/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

struct Platforms : Codable
{
    var platform : Platform
    enum CodingKeys : String, CodingKey{
    case platform = "platform"
    }
}
