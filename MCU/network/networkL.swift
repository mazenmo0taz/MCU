//
//  networkL.swift
//  MCU
//
//  Created by mazen moataz on 04/11/2021.
//

import Foundation
import CryptoKit

class MarvelData{
  
    
    let pubKey = "8e16e1c2eba204502d2a8fb140122b39"
    let privKey = "29bdd211664ed96f3da9b75ad170f686cc3523ba"
    //making hash paramter
    func MD5(ts:String,privKey: String,publKey:String) -> String {
        
        let hashParTxt = "\(ts)\(privKey)\(publKey)"
        
        let md5HashPar = Insecure.MD5.hash(data: hashParTxt.data(using: .utf8)!)
        return md5HashPar.map{
            String(format: "%02hhx", $0)
        }.joined()
        
    }
   
    
     func performRequest(baseUrl:String){
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts:ts, privKey: privKey, publKey: pubKey)
        let url = "\(baseUrl)&ts=\(ts)&apikey=\(pubKey)&hash=\(hash)"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: url)!) {( data, _, error ) in
            if let e = error {
                print(e.localizedDescription)
            }
            if let d = data{
                let decoder = JSONDecoder()
                do{
                    let chars = try decoder.decode(Result.self, from: d)
                    for i in 1...20{
                        print("character name = \(chars.data.results[i].name)   ,   character id = \(chars.data.results[i].id)")
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                print("no data found")
            }
    }
            
        task.resume()
    
       
}
}



