//
//  Cahracter.swift
//  MCU
//
//  Created by Islam Ibrahim on 06/11/2021.
//

struct CharacterDataResult: Codable {
    let data: CharacterData
}

struct CharacterData: Codable {
    let count: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
}
