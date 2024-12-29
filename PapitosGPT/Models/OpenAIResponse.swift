//
//  OpenAIResponse.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 27/12/24.
//

import Foundation

struct OpenAIResponse: Codable {
    struct Choice: Codable {
        let message: ChatMessage
    }
    let choices: [Choice]
}
