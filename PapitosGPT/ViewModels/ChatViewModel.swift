//
//  ChatViewModel.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 26/12/24.
//

import Foundation

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(content: "Hi! How can I help you today?", isUser: false)
    ]
    @Published var userInput: String = ""
    @Published var isLoading: Bool = false
    
    /// Selected OpenAI model (default is gpt-3.5-turbo)
    var selectedModel: OpenAI.Model = .gpt3_5Turbo
    
    /// Sends the user's input to the OpenAI API and appends the response
    func sendMessage() async {
        guard !userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        // Add user's input as a message in the chat
        let userMessage = Message(content: userInput, isUser: true)
        messages.append(userMessage)
        
        // Reset the input field
        userInput = ""
        
        // Set loading state
        isLoading = true
        
        // Prepare the conversation context for the API request
        let conversationMessages = messages.map {
            ChatMessage(role: $0.isUser ? "user" : "assistant", content: $0.content)
        }
        
        // Create the request body for OpenAI API
        let requestBody = OpenAIChatRequest(
            model: selectedModel,
            messages: [ChatMessage(role: "system", content: OpenAI.Default.systemMessage)] + conversationMessages,
            max_tokens: OpenAI.Default.maxTokens
        )
        
        do {
            // Call the OpenAI API
            let response: OpenAIResponse = try await APIService.shared.performRequest(
                endpoint: .chatCompletions,
                body: requestBody
            )
            
            // Remove the default greeting message if present
            if messages.first?.content == "Hi! How can I help you today?" {
                messages.removeFirst()
            }
            
            // Append the AI's response to the chat
            if let aiMessage = response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines) {
                messages.append(Message(content: aiMessage, isUser: false))
            }
        } catch {
            // Append an error message to the chat
            let errorMessage = (error as? APIError)?.localizedDescription ?? "Unexpected error occurred."
            messages.append(Message(content: "Failed to fetch a response: \(errorMessage)", isUser: false))
        }
        
        // Reset loading state
        isLoading = false
    }
}
