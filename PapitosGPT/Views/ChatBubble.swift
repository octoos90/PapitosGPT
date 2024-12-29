//
//  ChatBubble.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 26/12/24.
//

import SwiftUI

// MARK: - Chat Bubble View
struct ChatBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer() // Align user message to the right
                Text(message.content)
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .frame(maxWidth: 250, alignment: .trailing)
            } else {
                Text(message.content)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .frame(maxWidth: 250, alignment: .leading)
                Spacer() // Align AI message to the left
            }
        }
    }
}
