//
//  Stores.swift
//  Videojuegos
//
//  Created by MIMO on 27/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

struct Stores : Codable
{
    var store : Store
    enum CodingKeys : String, CodingKey{
    case store = "store"
    }
}
