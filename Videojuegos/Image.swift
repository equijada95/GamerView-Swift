//
//  Image.swift
//  Videojuegos
//
//  Created by MIMO on 31/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit
import Kingfisher
import KingfisherSwiftUI

class Image: UIImageView
{
    var imageView: UIImageView = UIImageView()
    
    func getImage(urlString: String) -> UIImageView
    {
        let url = URL(string: urlString)
        imageView.kf.setImage(with: url)
      //  {
      //      result in
      //      switch result {
      //      case .success(let value):
      //          print("Task done for: \(value.source.url?.absoluteString ?? "")")
      //      case .failure(let error):
      //          print("Job failed: \(error.localizedDescription)")
      //      }
      //  }
        return imageView
        
    }
}
