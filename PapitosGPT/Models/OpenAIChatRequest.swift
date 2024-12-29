//
//  OpenAIChatRequest.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 27/12/24.
//


struct OpenAIChatRequest: Codable {
    let model: String
    let messages: [ChatMessage]
    let max_tokens: Int
    
    init(model: OpenAI.Model, messages: [ChatMessage], max_tokens: Int = OpenAI.Default.maxTokens) {
        self.model = model.rawValue
        self.messages = messages
        self.max_tokens = max_tokens
    }
}

