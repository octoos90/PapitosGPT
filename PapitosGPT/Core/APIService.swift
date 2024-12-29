//
//  APIService.swift
//  PapitosGPT
//
//  Created by Octo Siswardhono on 27/12/24.
//

import Foundation

final class APIService {
    static let shared = APIService()
    private init() {}
    
    func performRequest<RequestBody: Codable, ResponseBody: Codable>(
        endpoint: OpenAI.Endpoint, // Use OpenAI.Endpoint enum
        method: String = "POST",
        body: RequestBody? = nil
    ) async throws -> ResponseBody {
        // Construct the URL using OpenAI's base URL
        guard let url = URL(string: "\(OpenAI.baseURL)\(endpoint.rawValue)") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("Bearer \(PapitosGPTManager.getAPIKey() ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode the request body if provided
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        // Execute the request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Validate the response status code
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        // Handle non-2xx responses
        guard (200...299).contains(httpResponse.statusCode) else {
            let serverMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw APIError.serverError(statusCode: httpResponse.statusCode, message: serverMessage)
        }
        
        // Decode the response body
        do {
            return try JSONDecoder().decode(ResponseBody.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}


// MARK: - API Error Handling
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int, message: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .decodingError:
            return "Failed to decode the response."
        case .serverError(let statusCode, let message):
            return "Server error (\(statusCode)): \(message)"
        }
    }
}
