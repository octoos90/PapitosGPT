//
//  OpenAI.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 28/12/24.
//


enum OpenAI {
    static let baseURL = "https://api.openai.com/v1"
    
    /// Supported Models
    enum Model: String {
        case gpt3_5Turbo = "gpt-3.5-turbo"
        case gpt4 = "gpt-4"
    }
    
    /// API Endpoints
    enum Endpoint: String {
        case chatCompletions = "/chat/completions"
    }
    
    /// Default Settings (optional)
    enum Default {
        static let maxTokens = 100
        static let systemMessage = "You are an AI assistant."
    }
}
