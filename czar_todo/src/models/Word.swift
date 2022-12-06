//
//  File.swift
//  czar_todo
//
//  Created by aluno on 08/11/22.
//

import Foundation


struct Word: Codable {
    
    let partOfSpeech: String?
    let meanings: [String]?
    let etymology: String?
    
    enum CodingKeys: String, CodingKey {
        case partOfSpeech = "partOfSpeech"
        case meanings = "meanings"
        case etymology = "etymology"
    }
    
    var word: Word {
        get {
            return self
        }

        set {
            self = newValue
        }
    }
}
