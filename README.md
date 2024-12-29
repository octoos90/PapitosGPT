# PapitosGPT

PapitosGPT is an iOS chatbot application powered by OpenAI's GPT models (GPT-3.5 and GPT-4). It is built using **Swift** and **SwiftUI**, following the **MVVM (Model-View-ViewModel)** architecture for scalability and maintainability.

---

## Table of Contents

- [Features](#features)
- [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Add OpenAI API Key](#add-openai-api-key)
  - [Run the Application](#run-the-application)
- [Architecture](#architecture)
- [Development Workflow](#development-workflow)
- [Contributing](#contributing)
- [License](#license)

---

## Features

### OpenAI Integration
- Chat with OpenAI's GPT models (GPT-3.5 and GPT-4).
- Dynamically switch between models for tailored responses.
- Customizable system messages for personalized assistant behavior.

### Real-Time Chat
- Responsive chat UI with user and assistant messages.
- Loading state indicator for active requests.

### Secure API Key Management
- API keys are securely managed and excluded from the repository to protect sensitive information.

### Scalable MVVM Architecture
- Clean separation of concerns between UI, business logic, and data management.

---

## Setup

### Prerequisites

- **Xcode**: Latest stable version (recommended: Xcode 14 or later).
- **Swift**: Version 5.7 or later.
- **OpenAI API Key**: Obtain an API key from OpenAI (see [Add OpenAI API Key](#add-openai-api-key)).

---

### Create an OpenAI API Key

To use the OpenAI API, you must generate an API key from OpenAI's platform:

1. **Sign up or log in** to the OpenAI platform:
   - Visit [https://platform.openai.com/signup/](https://platform.openai.com/signup/) to create an account if you don’t have one.
2. Navigate to the **API Keys** section in your OpenAI account:
   - After logging in, go to the [API Keys page](https://platform.openai.com/account/api-keys).
3. Click the **Create new secret key** button.
4. Copy the generated key:
   - This key will only be displayed once, so make sure to copy and store it securely.

> ⚠️ **Important**: Do not share your API key publicly or include it in source code pushed to a public repository.

---

### Add OpenAI API Key

Since API keys are not included in the repository for security reasons, follow these steps to set up your key:

#### 1. Create a `PapitosGPT.plist` File

1. In Xcode, navigate to the project directory.
2. Right-click and select **New File** > **Property List**.
3. Name the file `PapitosGPT.plist`.

#### 2. Add the API Key

1. Open the `PapitosGPT.plist` file.
2. Add a key-value pair:
   - **Key**: `OPENAI_API_KEY`
   - **Value**: Your OpenAI API key.

The file should look like this:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>OPENAI_API_KEY</key>
    <string>your-api-key-here</string>
</dict>
```

3. Update .gitignore
Ensure the PapitosGPT.plist file is ignored by Git. Add the following line to your .gitignore file:

```gitignore
PapitosGPT.plist
```

---

## Run the Application
1. Clone the repository:
   ```bash
   git clone https://github.com/octoos90/PapitosGPT.git
   cd papitosgpt
   ```

2. Open the project in Xcode:
    ```bash
   open EBuddy.xcodeproj
   ```

3. Select a simulator or connected device.
4. Press Cmd + R or click Run to build and run the app.
  
---

## Architecture

PapitosGPT follows the  **MVVM (Model-View-ViewModel)** pattern:
- **Model**: Defines the data structures for chat messages and API requests.
- **ViewModel**: Manages the logic of sending user messages and receiving AI responses.
- **View**: Built using SwiftUI, responsible for presenting the chat interface and responding to user interactions.

This architecture ensures:
- Clean separation of concerns.
- Easy maintainability and scalability.
- Simplified testing and debugging.

---
## Development Workflow
1. API Integration: Handled using a dedicated APIService class for making network requests to OpenAI's API.
2. Model Updates: Define data structures for OpenAI requests and responses.
3. UI Enhancements: Update chat interface as needed with SwiftUI.
4. Error Handling: Gracefully handle API errors and display fallback messages.

--- 

## Contributing

Contributions are welcome! Follow these steps:
1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Description of changes"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Create a Pull Request.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---
