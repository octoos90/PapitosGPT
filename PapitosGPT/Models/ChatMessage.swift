//
//  ChatMessage.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 27/12/24.
//


struct ChatMessage: Codable {
    let role: String // "system", "user", or "assistant"
    let content: String
}
