//
//  TranslationService.swift
//  Translation APP
//
//  Created by Rushil Prajapati on 5/22/25.
//

import Foundation

class TranslationService {
    static let shared = TranslationService()

    func translate(text: String, to targetLang: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/translate") else {
            completion(nil)
            return
        }

        let request = TranslationRequest(text: text, target_lang: targetLang.lowercased())
        guard let requestData = try? JSONEncoder().encode(request) else {
            completion(nil)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = requestData

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,
                  let decoded = try? JSONDecoder().decode(TranslationResponse.self, from: data) else {
                completion(nil)
                return
            }
            completion(decoded.translated_text)
        }.resume()
    }
}
