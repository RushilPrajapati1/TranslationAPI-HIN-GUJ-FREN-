//
//  ContentView.swift
//  Translation APP
//
//  Created by Rushil Prajapati on 5/22/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var inputText = ""
    @State private var selectedLang = "Hindi"
    @State private var translatedText = ""
    
    let languages = ["Hindi", "Gujarati", "French"]

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter text to translate", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Picker("Language", selection: $selectedLang) {
                ForEach(languages, id: \.self) { lang in
                    Text(lang)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Button("Translate") {
                var finalText = inputText
                if selectedLang.lowercased() == "gujarati" && !inputText.starts(with: ">>guj<<") {
                    finalText = ">>guj<< \(inputText)"
                }
                
                TranslationService.shared.translate(text: finalText, to: selectedLang) { result in
                    DispatchQueue.main.async {
                        self.translatedText = result ?? "Translation failed."
                    }
                }
            }


            Text("Translated:")
                .font(.headline)

            Text(translatedText)
                .foregroundColor(.blue)
                .padding()
            
            Button("🔊 Speak") {
                speak(translatedText, language: selectedLang)
            }
            .foregroundColor(.purple)
            .padding()
            

            Spacer()
        }
        .padding()
    }
    func speak(_ text: String, language: String) {
        let utterance = AVSpeechUtterance(string: text)

            let langCode: String
            switch language.lowercased() {
                case "hindi": langCode = "hi-IN"
                case "gujarati": langCode = "gu-IN"
                case "french": langCode = "fr-FR"
                default: langCode = "en-US"
            }

            // Fallback logic: prefer female, fallback to first available voice
            if let preferred = AVSpeechSynthesisVoice.speechVoices().first(where: {
                $0.language == langCode && $0.name.lowercased().contains("female")
            }) {
                utterance.voice = preferred
            } else if let anyVoice = AVSpeechSynthesisVoice(language: langCode) {
                utterance.voice = anyVoice
            }

            utterance.rate = 0.5
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
    }
    
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
