//
//  Videogame.swift
//  Videojuegos
//
//  Created by MIMO on 26/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import CoreData

struct Videogame : Codable
{
    var id: Int
    var name: String
    var image: String?
    var platforms: [Platforms]?
    var stores: [Stores]?
    var rating: Double
    var clip: Clip?
        
    enum CodingKeys : String, CodingKey{
        case id = "id"
        case name = "name"
        case image = "background_image"
        case platforms = "platforms"
        case stores = "stores"
        case rating = "rating"
        case clip = "clip"
        }
    
    // esta es la clase para codearlo, no la de core data

}

//extension StructDecoder {
//    func toCoreData(context: NSManagedObjectContext) throws -> NSManagedObject {
//    }
//}
