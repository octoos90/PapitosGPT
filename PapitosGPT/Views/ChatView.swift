//
//  ChatView.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 26/12/24.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var textFieldHeight: CGFloat = 40 // Default height for the TextEditor

    var body: some View {
        NavigationView {
            VStack {
                // Chat Messages List
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            ForEach(viewModel.messages, id: \.id) { message in
                                ChatBubble(message: message)
                                    .id(message.id) // Assign a unique ID for scrolling
                            }

                            // Show loading indicator when waiting for a response
                            if viewModel.isLoading {
                                HStack {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                    Text("Thinking...")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                                .padding(.top, 10)
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        .padding(.horizontal)
                        .onChange(of: viewModel.messages) {
                            withAnimation {
                                scrollViewProxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                            }
                        }
                    }
                }

                // Input Bar
                HStack(alignment: .bottom) {
                    // Dynamic TextEditor
                    ZStack(alignment: .leading) {
                        if viewModel.userInput.isEmpty {
                            Text("Enter your message...")
                                .foregroundColor(.gray)
                                .padding(.leading, 5)
                        }
                        TextEditor(text: $viewModel.userInput)
                            .padding(5)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                            .frame(minHeight: 40, maxHeight: 100) // Restrict the maximum height
                            .onChange(of: viewModel.userInput) { oldValue, newValue in
                                adjustTextFieldHeight(for: newValue)
                            }
                    }
                    .frame(height: textFieldHeight)

                    // Send Button
                    Button(action: {
                        Task {
                            await viewModel.sendMessage()
                        }
                        resetTextFieldHeight()
                    }) {
                        Text("Send")
                            .padding(.horizontal)
                            .frame(height: 40)
                            .background(viewModel.isLoading ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(viewModel.isLoading) // Disable button while loading
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("PapitosGPT")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Function to adjust the height of the TextEditor
    private func adjustTextFieldHeight(for text: String) {
        let lineCount = text.components(separatedBy: "\n").count
        textFieldHeight = min(40 + CGFloat(lineCount - 1) * 20, 100) // Adjust height based on line count
    }

    // Function to reset the TextEditor height
    private func resetTextFieldHeight() {
        textFieldHeight = 40
    }
}

// MARK: - Preview
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
