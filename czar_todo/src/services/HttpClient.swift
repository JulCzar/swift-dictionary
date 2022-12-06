//
//  File.swift
//  czar_todo
//
//  Created by aluno on 25/10/22.
//

import Foundation
import Alamofire

class HttpClient {
    var word: Word!
    
    func getJSON(url: String, parameters: Parameters? = nil, callback: @escaping (_ word: Word?) -> Void) {
        AF.request("https://significado.herokuapp.com/v2/\(url)", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            
            (responseData) in
            
            guard let data = responseData.data else {
                return
            }
            
            do {
                print("antes do JSON \(data)")
//                self.word = try JSONDecoder().decode([Word].self, from: data)[0]
                self.word = Word(partOfSpeech: "substantivo", meanings: ["Ato de Validar que algo funciona", "Validação de uma ação"], etymology: "do latim, testum")
                
                print("depois do JSON")
                self.save(key: "Word", value: self.word)
                 
                let result = self.get(key: "Word")
                
                callback(result)
            }
            catch {
                print("Parse Error...")
            }
        }
    }
    
    func save(key: String, value: Word) {        
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.setValue(data, forKey: key)
        }
        catch {
            
        }
        UserDefaults.standard.synchronize()
    }
    
    func get(key: String) -> Word? {
        var word: Word?
        
        do {
            let data = UserDefaults.standard.object(forKey: key) as! Data
            
            word = try JSONDecoder().decode(Word.self, from: data)
        }
        catch {
            
        }
        
        return word
    }
}
