//
//  TranslationModel.swift
//  Translation APP
//
//  Created by Rushil Prajapati on 5/22/25.
//

import Foundation

struct TranslationRequest: Codable {
    let text: String
    let target_lang: String
}

struct TranslationResponse: Codable {
    let translated_text: String
}
