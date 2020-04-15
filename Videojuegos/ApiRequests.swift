//
//  ApiRequests.swift
//  Videojuegos
//
//  Created by MIMO on 25/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit
import Alamofire


class ApiRequests{

    let afSession = Session(configuration: URLSessionConfiguration.default)
    
    func alamoFire(for name: String, for page: Int, completionHandler: @escaping(Search) -> Void)
    {
        afSession.request("https://api.rawg.io/api/games", method: .get, parameters: ["search":     name, "page": page]).validate().responseDecodable(of: Search.self)
        {
            response in
            switch response.result{
            case let .success(data):
            DispatchQueue.main.async {
                completionHandler(data)
                
            }
            case let .failure(error):
            print(error)
            
            
            }
        }.resume()
    }
}
