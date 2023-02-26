//
//  Webservice.swift
//  CyryptoCrazy
//
//  Created by Nur on 25.02.2023.
//

import Foundation

class Webservice {
    
    func downloadCurrencies(url: URL, completition: @escaping ([CryptoCurrency]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completition(nil)
            } else if let data = data {
                
                let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                
                if let cryptoList = cryptoList {
                    completition(cryptoList)
                }
            }
        }.resume()
    }
}
