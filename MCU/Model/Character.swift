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
    let description: String
    let thumbnail: Image
    let comics: ComicList
}

struct Image : Codable{
   let path:String
   let `extension`:String
}

struct ComicList: Codable {
    let available:Int // total number of stories available
    let returned:Int // number of returned stories
    let items: [ComicSummary]
}

struct ComicSummary:Codable {
    let resourceURI:String
    let name:String
}
