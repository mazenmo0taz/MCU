//
//  ApiResult.swift
//  MCU
//
//  Created by mazen moataz on 05/11/2021.
//

import Foundation

struct Result : Codable{
    var data : Data
}

struct Data : Codable{
    var count : Int
    var results : [chars]
}

struct chars : Codable {
    var id: Int
    var name : String
}
