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
//        m.performRequest(baseUrl: "https://gateway.marvel.com:443")
        
        m.request(with: "/v1/public/characters?limit=100&offset=100") { data in
            let chars = try? JSONDecoder().decode(CharacterDataResult.self, from: data)
            print(chars?.data.results)
        } failure: { error in
            print(error.localizedDescription)
        }
        
        
        let params = ["limit": 100, "offset": 100]
//        m.request(with: "/v1/public/characters", parameters: params) { data in
//            print(data)
//        } failure: { error in
//            print(error.localizedDescription)
//        }
        
        
//        m.request(with: "/v1/public/characters", parameters: params, method: .get) { data in
//            print(data)
//        } failure: { error in
//            print(error.localizedDescription)
//        }

    }
}

