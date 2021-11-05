//
//  ViewController.swift
//  MCU
//
//  Created by mazen moataz on 04/11/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let m = MarvelData()
        
        m.performRequest(baseUrl:  "https://gateway.marvel.com:443/v1/public/characters?limit=100&offset=100")
        }
    


}

