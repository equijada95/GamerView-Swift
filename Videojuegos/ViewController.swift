//
//  ViewController.swift
//  Videojuegos
//
//  Created by MIMO on 20/03/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var campo: UITextField!

    var apiRequest = ApiRequests()
    var items : [Videogame] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        campo.delegate = self    }
    
    
    @IBAction func pulsarOk() {
        
        if let juego = campo.text
        {
            apiRequest.alamoFire(for: juego, completionHandler: {
                items in
                    
                self.items = items
              //  print(self.items)
               
                self.performSegue(withIdentifier: "push", sender: self)
            })
            
            
        }
        campo.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tVC = segue.destination as? TableViewController
        {
            tVC.videogames = self.items
            
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return campo.resignFirstResponder()
    }
    
}
