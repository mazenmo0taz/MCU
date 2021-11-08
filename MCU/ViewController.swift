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
        let params = ["limit": 100, "offset": 300]
        m.request(with: "/v1/public/characters?", parameters: params, method: .get) { data in
            let chars = try? JSONDecoder().decode(CharacterDataResult.self, from: data)
            print(chars?.data.results ??  "error while fetching chars data")
        } failure: { error in
            print(error.localizedDescription)
        }

    }
}

