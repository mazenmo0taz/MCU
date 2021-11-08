//
//  networkL.swift
//  MCU
//
//  Created by mazen moataz on 04/11/2021.
//

import Foundation
import CryptoKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


class MarvelData {
  
    let baseURL = "https://gateway.marvel.com:443"
    let pubKey = "8e16e1c2eba204502d2a8fb140122b39"
    let privKey = "29bdd211664ed96f3da9b75ad170f686cc3523ba"
    func request(with path: String,
                 parameters: [String: Any]? = nil,
                 method: HTTPMethod = .get,
                 headers: [String: Any]? = nil,
                 success: @escaping(Data) -> Void,
                 failure: @escaping(Error) -> Void) {
        
        let timeStamp = String(Date().timeIntervalSince1970)
        let generatedHash = generateHashData(timeStamp)
        let session = URLSession(configuration: .default)
        
        let url = "\(baseURL)\(path)&ts=\(timeStamp)&apikey=\(pubKey)&hash=\(generatedHash)"
        var urlRequest = URLRequest(url: URL(string:url)!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        if var params = parameters{
            params["ts"] = timeStamp
            params["apikey"] = pubKey
            params["hash"] = generatedHash
            switch method{
            case .get:
                var urlComponents = URLComponents(string: url)
                urlComponents?.queryItems = params.map{URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponents?.url
            case .post:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let endpointError = error {
                failure(endpointError)
            }
            if let responseData = data {
                success(responseData)
                
            }
        }
        task.resume()
    }
}

private extension MarvelData {
    
    func generateHashData(_ timeStamp: String) -> String {
        let hash = MD5(timeStamp: timeStamp, privKey: privKey, publKey: pubKey)
        return hash
    }
    
    func MD5(timeStamp: String, privKey: String, publKey:String) -> String {
        
        let hashParTxt = "\(timeStamp)\(privKey)\(publKey)"
        let md5HashPar = Insecure.MD5.hash(data: hashParTxt.data(using: .utf8)!)
        return md5HashPar.map{
            String(format: "%02hhx", $0)
        }.joined()
    }
}
