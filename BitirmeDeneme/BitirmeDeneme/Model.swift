//
//  Model.swift
//  BitirmeDeneme
//
//  Created by Hasan Hüseyin Kılıç on 10.11.2024.
//
import Foundation

struct NewsValidationResult: Identifiable {
    let id = UUID()
    let accuracy: Double // Doğruluk oranı
    let explanation: String // Kısa açıklama
}


struct OpenAIResponse: Decodable {
    let choices: [Choice]
}

struct Choice: Decodable {
    let message: Message
}

struct Message: Decodable {
    let content: String
}
