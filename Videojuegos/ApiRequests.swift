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
    var tVC = TableViewController()
    
    func alamoFire(for nombre: String, completionHandler: @escaping([Videogame]) -> Void)
    {
      /*  afSession.request("https://api.rawg.io/api/games", method: .get, parameters: ["search":     nombre])
            .responseString{
            (response) in
            switch response.result{
            case let .success(cadena):
                
                 // self.label.text = cadena
                do{
                    var data = try JSONDecoder().decode(Search.self, from: cadena.data(using: .utf8)!)
                  //  print(cadena)
                  //  print(data)
                    DispatchQueue.main.async {
                        self.tVC.videogames = data.results
                        
                    }
                    
                   // for i in 0..<((data.results.count)-1){
                       // var lbl = UILabel(frame: CGRect(x: 50, y: 50+i*40, width: 200, height: 50))
                     //   lbl.text = data.results[i].name
                      //  self.view.addSubview(lbl)
                    //}
                    
                    
                }catch
                {
                    print(error)
                }
    
                /* self.label.text = data?.results.first?.name
                 var urlImagen = data?.results.first?.image
                 var url = URL(string: urlImagen!)
                let data1 = try? Data(contentsOf: url!)
                 self.caratula.image = UIImage(data: data1!)*/
    
    
            case let .failure(error):
                print(error)
                // poner una alerta de que no hay resultados
            }
        }*/
        
        afSession.request("https://api.rawg.io/api/games", method: .get, parameters: ["search":     nombre]).validate().responseDecodable(of: Search.self)
        {
            response in
            switch response.result{
            case let .success(data):
            DispatchQueue.main.async {
                completionHandler(data.results)
                
            }
            case let .failure(error):
            print(error)
            
            
            }
        }.resume()
    }
}
